class CarInterestsController < ApplicationController

  after_action :verify_authorized
  def create
    car_interest = CarInterest.new(car_interest_params)
    authorize car_interest,  policy_class: CarInterestPolicy
    car_interest.save!
    buy_process = car_interest.buy_process
    if current_user.has_role?('admin')
      redirect_to admin_buy_process_path(buy_process)
    else current_user.has_role?('sales')
      redirect_to sales_buy_process_path(buy_process)
    end
  end

  def destroy
    car_interest = CarInterest.find(params[:id])
    authorize car_interest,  policy_class: CarInterestPolicy
    buy_process = car_interest.buy_process
    car_interest.destroy!
    if current_user.has_role?('admin')
      redirect_to admin_buy_process_path(buy_process)
    else current_user.has_role?('sales')
      redirect_to sales_buy_process_path(buy_process)
    end
  end

  private

  def car_interest_params
    params.require(:car_interest).permit(:car_intake_id, :buy_process_id)
  end
end
