class CarIntakePolicy
  attr_reader :current_user, :car_intake

  def initialize(current_user, car_intake)
    @current_user = current_user
    @car_intake = car_intake
  end

  def index?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def new?
    create?
  end

  def create?
    @current_user.has_role?('admin')
  end

end