module Sales
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    has_scope :client_name_contains
    has_scope :client_email_contains
    has_scope :created_at_date_from
    has_scope :created_at_date_to
    has_scope :without_notes, type: :boolean
    has_scope :successfully_closed_at_date_from
    has_scope :successfully_closed_at_date_to
    has_scope :unsuccessfully_closed_at_date_from
    has_scope :unsuccessfully_closed_at_date_to


    def index
      authorize BuyProcess,  policy_class: Sales::BuyProcessPolicy

      # includes(:client).references(:clients) is needed when we are both joining and including an association
      # in a query.
      @buy_processes = apply_scopes(BuyProcess)
                           .currently_open
                           .user_id_is(current_user.id)
                           .select('buy_processes.*, count(notes.id) AS total_notes')
                           .inner_joins_client
                           .includes(:client).references(:clients)
                           .left_outer_joins(:notes)
                           .group('buy_processes.id')
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page])
      @without_notes_select_options = [['Sin comentarios', true]]

    end


    def show
      @buy_process = BuyProcess.find(params[:id])
      authorize @buy_process,  policy_class: Sales::BuyProcessPolicy
      @client = @buy_process.client
      @user = @buy_process.user
      @buy_process_inquiries = @buy_process.buy_process_inquiries
      @notes = @buy_process.notes
      @car_interests = @buy_process.car_interests.includes(:car, :car_interest_inquiries)
      @note = Note.new(buy_process: @buy_process)
      @new_car_interest = CarInterest.new(buy_process_id: @buy_process.id)
      cars_in_buy_process = @car_interests.pluck(:car_id)
      @available_cars_select = Car.available.where.not(id: cars_in_buy_process).order(description: :asc, registration: :asc).map{ |car| [car.registration_and_description, car.id] }
    end


    def create
      @buy_process = BuyProcess.new(buy_process_params.merge(user_id: current_user.id, source: 'Vitrina'))
      authorize([:sales, @buy_process])
      @buy_process.save!
      redirect_to sales_buy_process_path(@buy_process)
    end

    def successfully_closed_index
      authorize BuyProcess,  policy_class: Sales::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .user_id_is(current_user.id)
                           .successfully_closed_processes
                           .includes(:client)
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page])
    end

    def unsuccessfully_closed_index
      authorize BuyProcess,  policy_class: Sales::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .user_id_is(current_user.id)
                           .unsuccessfully_closed_processes
                           .includes(:client)
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page])
    end

    def mark_as_successfully_closed
      @buy_process = BuyProcess.find(params[:id])
      authorize([:sales, @buy_process])
      @buy_process.update!(successfully_closed_at: Time.now.to_datetime)
      redirect_to sales_buy_process_path(@buy_process)
    end

    def mark_as_unsuccessfully_closed
      @buy_process = BuyProcess.find(params[:id])
      authorize([:sales, @buy_process])
      @buy_process.update!(unsuccessfully_closed_at: Time.now.to_datetime)
      redirect_to sales_buy_process_path(@buy_process)
    end

    private

    def buy_process_params
      params.require(:buy_process).permit(:client_id)
    end
  end
end
