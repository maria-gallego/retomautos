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

    def new?
      @current_user.has_role?('sales') || @current_user.has_role?('admin')
    end

    def successfully_closed_index?
      @current_user.has_role?('sales')
      end

    def unsuccessfully_closed_index?
      @current_user.has_role?('sales')
    end

    def mark_as_successfully_closed?
      salesman_allowed = @buy_process.notes.size > 0 && @current_user.has_role?('sales') && @buy_process.user == @current_user
      admin_allowed = @current_user.has_role?('admin')
      salesman_allowed || admin_allowed
    end

    def mark_as_unsuccessfully_closed?
      salesman_allowed = @buy_process.notes.size > 0 && @current_user.has_role?('sales') && @buy_process.user == @current_user
      admin_allowed = @current_user.has_role?('admin')
      salesman_allowed || admin_allowed
    end
  end
end
