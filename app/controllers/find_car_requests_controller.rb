class FindCarRequestsController < ApplicationController
  def new
    @find_car_request = FindCarRequest.new

    #set_meta_tags title: 'Carros usados Bogotá',
    #              description: 'Encuentra una amplia selección de carros usados a precios muy competitivos, con facilidad de financiación, agilidad en los trámites y compra segura.',
    #              keywords: 'Carros usados'
  end

  def create
    @find_car_request = FindCarRequest.new(secure_params)
    if @find_car_request.valid?
      FindCarRequestMailer.staff_email(@find_car_request).deliver_now
      #FindCarRequestMailer.customer_email(@find_car_request).deliver_now
      flash[:notice] = "#{@find_car_request.name} tu solicitud ha sido enviada."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:find_car_request).permit(:name, :email, :content, :phone, :make, :year_from, :year_to, :budget)
  end

end
