class CarsController < ApplicationController

  after_action :verify_authorized

  def edit
    @car = Car.find(params[:id])
    authorize @car, policy_class: CarPolicy
  end

  def update
    @car = Car.find(params[:id])
    authorize @car, policy_class: CarPolicy
    @car.update!(car_params)
    flash[:success] = 'Carro editado'
    redirect_to car_intakes_path
  end


  private

  def car_params
    params.require(:car).permit(:description, :year, :registration)
  end
end
