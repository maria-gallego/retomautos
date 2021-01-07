module Admin
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    has_scope :client_name_contains
    has_scope :client_email_contains
    has_scope :created_at_date_from
    has_scope :created_at_date_to
    has_scope :user_id_is
    has_scope :without_notes, type: :boolean
    has_scope :successfully_closed_at_date_from
    has_scope :successfully_closed_at_date_to
    has_scope :unsuccessfully_closed_at_date_from
    has_scope :unsuccessfully_closed_at_date_to

    def index

      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      # includes(:client).references(:clients) is needed when we are both joining and including an association
      # in a query.
      @buy_processes = apply_scopes(BuyProcess)
                           .currently_open
                           .select('buy_processes.*, count(notes.id) AS total_notes')
                           .inner_joins_client
                           .includes(:client, :user).references(:clients)
                           .left_outer_joins(:notes)
                           .group('buy_processes.id')
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page], per_page: 30)


      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

    def show
      @buy_process = BuyProcess.find(params[:id])
      authorize @buy_process,  policy_class: Admin::BuyProcessPolicy
      @client = @buy_process.client
      @user = @buy_process.user
      @buy_process_inquiries = @buy_process.buy_process_inquiries
      @notes = @buy_process.notes
      @car_interests = @buy_process.car_interests.includes(car_intake: [:car], car_interest_inquiries: [])
      @note = Note.new(buy_process: @buy_process)
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @new_car_interest = CarInterest.new(buy_process_id: @buy_process.id)
      @available_car_intakes_select = CarIntake.available_for_buy_process(@buy_process)
                                          .joins(:car)
                                          .order("cars.description ASC, cars.registration ASC")
                                          .includes(:car)
                                          .map{ |car_intake| [car_intake.car.registration_and_description, car_intake.id] }
    end

    def create
      @buy_process = BuyProcess.new(buy_process_params.merge(source: 'Vitrina'))
      authorize([:admin, @buy_process])
      @buy_process.save!
      redirect_to admin_buy_process_path(@buy_process)
    end

    def update
      @buy_process = BuyProcess.find(params[:id])
      authorize @buy_process, policy_class:Admin::BuyProcessPolicy
      @buy_process.update!(buy_process_params)
      # @buy_process.update(user_id: 3, name: 'foo')
      flash[:success] = 'Vendedor cambiado exitosamente'
      redirect_to admin_buy_process_path(@buy_process)
    end

    def successfully_closed_index
      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy
      @buy_processes = apply_scopes(BuyProcess)
                           .successfully_closed_processes
                           .includes(:client)
                           .order('car_sales.created_at DESC')
                           .paginate(page: params[:page])
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

    def unsuccessfully_closed_index
      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .unsuccessfully_closed_processes
                           .includes(:client)
                           .order('buy_processes.unsuccessfully_closed_at DESC')
                           .paginate(page: params[:page])
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

    # TODO: successfully_closed_at -> car_sale
    def mark_as_successfully_closed
      @buy_process = BuyProcess.find(params[:id])
      authorize([:admin, @buy_process])
      @buy_process.update!(successfully_closed_at: Time.now.to_datetime)
      redirect_to admin_buy_process_path(@buy_process)
    end

    def mark_as_unsuccessfully_closed
      @buy_process = BuyProcess.find(params[:id])
      authorize([:admin, @buy_process])
      @buy_process.update!(unsuccessfully_closed_at: Time.now.to_datetime)
      redirect_to admin_buy_process_path(@buy_process)
    end

    private

    def buy_process_params
      params.require(:buy_process).permit(:user_id, :client_id)
    end

  end
end