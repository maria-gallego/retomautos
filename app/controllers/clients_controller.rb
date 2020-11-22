class ClientsController < ApplicationController

  after_action :verify_authorized

  has_scope :client_name_contains
  has_scope :client_email_contains

  def index
    authorize nil, policy_class: ClientPolicy
    @clients = apply_scopes(Client)
                   .paginate(page: params[:page])
  end

  def show
    authorize nil, policy_class: ClientPolicy
    @client = Client.find(params[:id])
    @last_buy_process = @client.last_buy_process
    @last_open_buy_process = @client.last_open_buy_process
    @buy_process_create_policy_instance = BuyProcess.new(client: @client, user: current_user)
  end

  def new
    authorize nil, policy_class: ClientPolicy
    @client = Client.new
  end

  def create
    authorize nil, policy_class: ClientPolicy
    existing_client = Client.find_by(email: client_params[:email])
    if existing_client.present?
      existing_client.update(client_params)
      redirect_to client_path(existing_client) and return
    end
    @client = Client.new(client_params)
    if @client.save!
      redirect_to client_path(@client)
    else
      flash[:danger] = 'No se pudo crear el cliente'
      render :new
    end
  end

  def edit
    authorize nil, policy_class: ClientPolicy
    @client = Client.find(params[:id])
  end

  def update
    authorize nil, policy_class: ClientPolicy
    @client = Client.find(params[:id])
    @client.update!(client_params)
    redirect_to client_path(@client)
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
