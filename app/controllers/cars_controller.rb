class CarsController < ApplicationController

  after_action :verify_authorized

  has_scope :registration_contains
  has_scope :year_range, using: %i[year_from yer_to], type: :hash

  def index
    authorize nil, policy_class:  CarPolicy
    @cars = apply_scopes(Car)
                .order('created_at DESC')
                .paginate(page: params[:page], per_page: 10)
  end

  def new
    @car = Car.new
    authorize @car, policy_class:  CarPolicy
  end

  def create
    existing_car = Car.find_by_registration(car_params[:registration])
    authorize existing_car, policy_class: CarPolicy
    if existing_car.present?
      flash[:danger] = "Ya existe un carro con esta placa"
      redirect_to cars_path and return
    end

    @car = Car.new(car_params)
    if @car.save
      flash[:success] = "Carro creado"
      redirect_to cars_path
    else
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
    authorize @car, policy_class: CarPolicy
  end

  def update
    @car = Car.find(params[:id])
    authorize @car, policy_class: CarPolicy
    @car.update!(car_params)
    flash[:success] = 'Carro editado'
    redirect_to cars_path
  end


  private

  def car_params
    params.require(:car).permit(:description, :year, :registration)
  end
end
