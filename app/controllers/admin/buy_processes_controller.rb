module Admin
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    has_scope :client_name_contains
    has_scope :client_email_contains
    has_scope :created_at_date_from
    has_scope :created_at_date_to
    has_scope :user_id_is
    has_scope :without_notes, type: :boolean

    def index

      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .all
                           .includes(:client, :user)
                           .currently_open
                           .select('buy_processes.*,  count(notes.id) as notes_count').left_outer_joins(:notes).group('buy_processes.id')
                           .order('buy_processes.created_at DESC')
                           .paginate(page: params[:page], per_page: 30)
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

    #show: it is using sales show for now. If required create a show action here.

    def successfully_closed_index
      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .all
                           .successfully_closed_processes
                           .includes(:client)
                           .order('buy_processes.successfully_closed_at DESC')
                           .paginate(page: params[:page])
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

    def unsuccessfully_closed_index
      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .all
                           .unsuccessfully_closed_processes
                           .includes(:client)
                           .order('buy_processes.unsuccessfully_closed_at DESC')
                           .paginate(page: params[:page])
      @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
      @without_notes_select_options = [['Sin comentarios', true]]
    end

  end
end