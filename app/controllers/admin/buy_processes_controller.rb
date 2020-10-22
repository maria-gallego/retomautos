module Admin
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    has_scope :client_name_contains
    has_scope :client_email_contains
    has_scope :created_at_date_from
    has_scope :created_at_date_to
    has_scope :user_id_is

    def index

      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = apply_scopes(BuyProcess)
                           .all
                           .includes(:client)
                           .includes(:user)
                           .paginate(page: params[:page], per_page: 30)
                           .order 'buy_processes.created_at DESC'
      @active_salespeople_select =  User.active_salespeople.pluck(:name,:id)

    end

    #show: it is using sales show for now. If required create a show action here.



  end
end