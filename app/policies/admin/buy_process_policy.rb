module Admin
  class BuyProcessPolicy
    attr_reader :current_user, :buy_process

    def initialize(current_user, buy_process)
      @current_user = current_user
      @buy_process = buy_process
    end

    def index?
      @current_user.has_role?('admin')
    end

  end
end