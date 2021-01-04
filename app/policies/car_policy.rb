class CarPolicy

  attr_reader :current_user, :car

  def initialize(current_user, car)
    @current_user = current_user
    @car = car
  end

  def edit?
    @current_user.has_role?('admin')
  end

  def update?
    @current_user.has_role?('admin')
  end
end
