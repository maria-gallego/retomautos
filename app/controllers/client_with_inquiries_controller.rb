class ClientWithInquiriesController < ApplicationController

  skip_before_action :authenticate_user!

  def create_from_financing
    @client_with_inquiry = ClientWithInquiry.new(client_with_inquiry_params.merge(source: 'Financiación'))
    if @client_with_inquiry.save
      redirect_to gracias_path
    else
      render "visitors/financing"
    end
  end

  def create_from_home
    @client_with_inquiry = ClientWithInquiry.new(client_with_inquiry_params.merge(source: 'Inicio'))
    if @client_with_inquiry.save
      #flash[:success] = "Gracias #{@client_with_inquiry.client_name}! Un asesor se va a comunicar contigo muy pronto"
      redirect_to gracias_path
    else
      set_car_slides
      render "visitors/home"
    end
  end

  private

  def client_with_inquiry_params
    params.require(:client_with_inquiry).permit(:client_name, :client_email, :client_phone, :buy_process_inquiry_body)
  end
end
