module Sales
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    has_scope :client_name_contains
    has_scope :client_email_contains
    has_scope :created_at_date_from
    has_scope :created_at_date_to
    has_scope :without_notes, type: :boolean

    def index
      authorize BuyProcess,  policy_class: Sales::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .user_id_is(current_user.id)
                           .includes(:client)
                           .select('buy_processes.*,  count(notes.id) as notes_count').left_outer_joins(:notes).group('buy_processes.id')
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page])
      @without_notes_select_options = [['Sin comentarios', true]]
    end


    def show
      @buy_process = BuyProcess.find(params[:id])
      authorize([:sales, @buy_process])
        # Is the same as:
        # authorize @buy_process,  policy_class: Sales::BuyProcessPolicy
      @client = @buy_process.client
      @user = @buy_process.user
      @buy_process_inquiries = @buy_process.buy_process_inquiries
      @notes = @buy_process.notes
      @car_interests = @buy_process.car_interests.includes(:car, :car_interest_inquiries)
      @note = Note.new(buy_process: @buy_process)
    end

  end
end
