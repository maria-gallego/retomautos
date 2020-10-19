module Sales
  class BuyProcessPolicy

    attr_reader :current_user, :buy_process

    def initialize(current_user, buy_process)

      @current_user = current_user
      @buy_process = buy_process
    end

    def index?
      @current_user.has_role?('sales')
    end

    def show?
      @current_user.has_role?('sales') && @buy_process.user == @current_user
    end

  end
end
