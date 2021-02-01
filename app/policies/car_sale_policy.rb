class CarSalePolicy
  attr_reader :current_user, :car_sale

  def initialize(current_user, car_sale)
    @current_user = current_user
    @car_sale = car_sale
  end

  def index?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def new?
    create?
  end

  def create?
    buy_process = @car_sale.buy_process
    return false unless buy_process.active?
    return true if @current_user.has_role?('admin')

     @current_user.has_role?('sales') && buy_process.user == @current_user && buy_process.notes.size > 0
  end
end