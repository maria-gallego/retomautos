class FindCarRequestsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @find_car_request = FindCarRequest.new

    set_meta_tags title: 'Encontramos tu carro',
                  description: 'Si no encontraste lo que estabas buscando, llena este formulario y te contacteremos cuando tengamos tu próximo carro',
                  keywords: 'Carros usados'
  end

  def create
    @find_car_request = FindCarRequest.new(secure_params)
    @find_car_request.salesperson = User.get_random_salesperson
    if @find_car_request.valid?
      FindCarRequestMailer.staff_email(@find_car_request).deliver_now
      FindCarRequestMailer.customer_email(@find_car_request).deliver_now
      flash[:success] = "#{@find_car_request.name} tu solicitud ha sido enviada."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:find_car_request).permit(:name, :email, :content, :phone, :make, :reference, :year_from, :year_to, :budget_from, :budget_to, :plate)
  end

end