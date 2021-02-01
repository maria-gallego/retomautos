class ClientsController < ApplicationController
  after_action :verify_authorized

  has_scope :client_name_contains
  has_scope :client_email_contains


  def index
    authorize nil, policy_class: ClientPolicy
    @clients = apply_scopes(Client)
                   .paginate(page: params[:page])
  end


  def find_client_for_new_process
    authorize nil, policy_class: ClientPolicy
    flash[:success] = "Para crear el proceso primero se debe buscar el cliente y desde el perfil se crea el nuevo proceso"
    redirect_to clients_path
  end

  def show
    @client = Client.find(params[:id])
    authorize @client, policy_class: ClientPolicy
    @client_buy_processes = @client.buy_processes.includes(:user)
    @last_open_buy_process = @client.last_open_buy_process
    @active_salespeople_select =  User.active_salespeople.pluck(:name, :id)
    @admin_new_buy_process = BuyProcess.new(client: @client)
    @sales_new_buy_process = BuyProcess.new(client: @client, user: current_user)
  end

  def new
    @client = Client.new
    authorize @client, policy_class: ClientPolicy
  end

  def create
    existing_client = Client.find_by(email: client_params[:email])
    authorize existing_client, policy_class: ClientPolicy
    if existing_client.present?
      existing_client.update!(client_params)
      redirect_to client_path(existing_client) and return
    end
    @client = Client.new(client_params)
    if @client.save
      redirect_to client_path(@client)
    else
      flash[:danger] = 'No se pudo crear el cliente'
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
    authorize @client, policy_class: ClientPolicy
  end

  def update
    @client = Client.find(params[:id])
    authorize @client, policy_class: ClientPolicy
    @client.update!(client_params)
    redirect_to client_path(@client)
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
