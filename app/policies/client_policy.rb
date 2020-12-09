class ClientPolicy

  attr_reader :current_user, :client

  def initialize(current_user, client)
    @current_user = current_user
    @client = client
  end

  def index?
    @current_user.has_role?('sales')|| @current_user.has_role?('admin')
  end

  def find_client_for_new_process?
    index?
  end

  def show?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def new?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def create?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def edit?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end

  def update?
    @current_user.has_role?('sales') || @current_user.has_role?('admin')
  end
end

