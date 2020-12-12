module Admin
  class CarPolicy

    attr_reader :current_user, :car

    def initialize(current_user, car)
      @current_user = current_user
      @car = car
    end

    def new?
      @current_user.has_role?('admin')
    end

    def create?
      @current_user.has_role?('admin')
    end

    def destroy?
      @current_user.has_role?('admin')
    end

  end
end