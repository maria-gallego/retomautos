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

    def show?
      @current_user.has_role?('admin')
    end

    def create?
      client = @buy_process.client
      @current_user.has_role?('admin') && !client.has_open_buy_process?
    end

    def update?
      @current_user.has_role?('admin') && @buy_process.active?
    end

    def successfully_closed_index?
      @current_user.has_role?('admin')
    end

    def unsuccessfully_closed_index?
      @current_user.has_role?('admin')
    end

    def mark_as_unsuccessfully_closed?
      @current_user.has_role?('admin')
    end

  end
end