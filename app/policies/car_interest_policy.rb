class CarInterestPolicy

  attr_reader :current_user, :car_interest

  def initialize(current_user, car_interest)
  @current_user = current_user
  @car_interest = car_interest
  end

  def create?
    buy_process = @car_interest.buy_process
    (@current_user.has_role?('sales') || @current_user.has_role?('admin')) && buy_process.active?
  end

  def destroy?
    buy_process = @car_interest.buy_process
    user_is_authorized = (@current_user.has_role?('sales') && buy_process.user == @current_user) || @current_user.has_role?('admin')
    car_interest_has_no_inquiries = @car_interest.car_interest_inquiries.size == 0
    user_is_authorized && car_interest_has_no_inquiries && buy_process.active?
  end
end

