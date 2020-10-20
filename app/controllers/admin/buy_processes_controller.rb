module Admin
  class BuyProcessesController < ApplicationController

    after_action :verify_authorized

    def index

      authorize BuyProcess,  policy_class: Admin::BuyProcessPolicy

      @buy_processes = BuyProcess
                           .all
                           .includes(:client)
                           .includes(:user)
                           .paginate(page: params[:page], per_page: 30)
                           .order! 'created_at DESC'
    end

    #show: it is using sales show for now. If required create a show action here.



  end
end