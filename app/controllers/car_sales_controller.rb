class CarSalesController < ApplicationController

  after_action :verify_authorized

  def new
    @buy_process = BuyProcess.find(params[:buy_process_id])
    @car_sale = CarSale.new(buy_process: @buy_process)
    authorize @car_sale, policy_class:  CarSalePolicy

    @available_car_interests_select = @buy_process.car_interests.includes(car_intake: [:car]).map do |car_interest|
      car_intake = car_interest.car_intake
      [car_intake.car.registration_and_description, car_intake.id]
    end
  end

  def create
    @car_sale = CarSale.new(car_sale_params)
    authorize @car_sale, policy_class:  CarSalePolicy
    @car_sale.save!
    if current_user.has_role?('admin')
      redirect_to admin_buy_process_path(car_sale_params[:buy_process_id])
    else current_user.has_role?('sales')
      redirect_to sales_buy_process_path(car_sale_params[:buy_process_id])
    end
  end

  def index
  end

  private

  def car_sale_params
    params.require(:car_sale).permit(:buy_process_id, :car_intake_id )
  end

end
