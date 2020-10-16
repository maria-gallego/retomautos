module Sales
  class BuyProcessesController < ApplicationController

    def index
      # TODO: enforce authorization
      #if !current_user.has_role?('sales')
      #  flash[:alert] = "no estas autorizado"
      #  redirect_to root_path
      #end

      @buy_processes = BuyProcess
                           .user_id_is(current_user.id)
                           .includes(:client)
                           .paginate(page: params[:page], per_page: 10)
                           .order! 'created_at DESC'
    end

    def show
      @buy_process = BuyProcess
                         .find(params[:id])
      @client = @buy_process.client
      @buy_process_inquiries = @buy_process.buy_process_inquiries
      @notes = @buy_process.notes
      @car_interests = @buy_process.car_interests.includes(:car, :car_interest_inquiries)
      @note = Note.new(buy_process: @buy_process)
    end
  end
end
