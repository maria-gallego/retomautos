class CarsController < ApplicationController

  after_action :verify_authorized

  has_scope :registration_contains
  has_scope :year_range, using: %i[year_from yer_to], type: :hash

  def index
    authorize Car, policy_class:Admin::CarPolicy
    @cars = apply_scopes(Car)
                .order('created_at DESC')
                .paginate(page: params[:page], per_page: 10)
  end

  def new
    authorize nil, policy_class:Admin::CarPolicy
    @car = Car.new
  end

  def create
    authorize nil, policy_class:Admin::CarPolicy
    existing_car = Car.find_by_registration(car_params[:registration])
    if existing_car.present?
      flash[:danger] = "Ya existe un carro con esta placa"
      redirect_to cars_path and return
    end
    @car = Car.new(car_params)
    if @car.save!
      flash[:success] = "Carro creado"
      redirect_to cars_path
    else
      redirect_to new_car_path
    end
  end

  def edit
    authorize nil, policy_class:Admin::CarPolicy
    @car = Car.find(params[:id])
  end

  def update
    authorize nil, policy_class:Admin::CarPolicy
    @car = Car.find(params[:id])
    @car.update!(car_params)
    flash[:success] = 'Carro editado'
    redirect_to cars_path
  end


  private

  def car_params
    params.require(:car).permit(:description, :year, :registration)
  end
end
