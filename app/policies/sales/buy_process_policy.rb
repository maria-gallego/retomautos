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
      (@current_user.has_role?('sales') && @buy_process.user == @current_user) || @current_user.has_role?('admin')
    end

    def successfully_closed_index?
      @current_user.has_role?('sales')
      end

    def unsuccessfully_closed_index?
      @current_user.has_role?('sales')
    end

    def mark_as_successfully_closed?
      (@current_user.has_role?('sales') && @buy_process.user == @current_user) || @current_user.has_role?('admin')
    end

    def mark_as_unsuccessfully_closed?
      (@current_user.has_role?('sales') && @buy_process.user == @current_user) || @current_user.has_role?('admin')
    end
  end
end
