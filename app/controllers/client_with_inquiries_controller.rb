class ClientWithInquiriesController < ApplicationController

  skip_before_action :authenticate_user!

  def create
    @client_with_inquiry = ClientWithInquiry.new(client_with_inquiry_params)
    if @client_with_inquiry.save
      flash[:success] = "Gracias #{@client_with_inquiry.client_name}! Un asesor se va a comunicar contigo muy pronto"
      redirect_to root_path
    else
      flash.now[:danger] = "El formulario tiene algunos errores"
      render 'visitors/financing'
    end
  end

  private

  def client_with_inquiry_params
    params.require(:client_with_inquiry).permit(:client_name, :client_email, :client_phone, :inquiry_body)
  end
end
