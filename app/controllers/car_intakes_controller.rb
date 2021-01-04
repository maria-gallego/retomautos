class CarIntakesController < ApplicationController

  after_action :verify_authorized

  has_scope :car_registration_contains
  has_scope :car_year_from
  has_scope :car_year_to

  def index
    authorize nil, policy_class:  CarIntakePolicy
    @car_intakes = apply_scopes(CarIntake.available)
                  .order('created_at DESC')
                  .includes(:car)
                  .paginate(page: params[:page], per_page: 10)
  end

  def new
    @car_intake_with_car = CarIntakeWithCar.new
    authorize @car_intake_with_car, policy_class:  CarIntakePolicy
  end

  def create
    @car_intake_with_car = CarIntakeWithCar.new(car_intake_with_car_params)
    authorize @car_intake_with_car, policy_class: CarIntakePolicy

    existing_car = Car.find_by(registration: car_intake_with_car_params[:car_registration])
    if existing_car.present?
      flash[:alert] = "Ya existe un carro con esta placa"
      redirect_to car_intakes_path and return
    end

    if @car_intake_with_car.save
      flash[:success] = "Carro creado"
      redirect_to car_intakes_path
    else
      render :new
    end
  end

  private

  def car_intake_with_car_params
    params.require(:car_intake_with_car).permit(:car_description, :car_year, :car_registration, :car_intake_tu_carro_id)
  end
end
