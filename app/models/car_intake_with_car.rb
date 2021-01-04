class CarIntakeWithCar
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :car_description, :car_year, :car_registration, :car_intake_tu_carro_id

  # Validations
  # =================================
  # Validations from Car
  validates :car_description, presence: true
  validates :car_year, presence: true
  validates :car_registration, presence: true, format: { with: /\A[A-Z]{3}\d{3}\z/,
                                                     message: "debe seguir el formato ABC123" }

  # Callback
  # ========================
  before_validation :normalize_registration


  # Class methods
  # =================================
  def self.create!(params)
    new(**params).save!
  end

  # Instance methods
  # =================================
  def save
    if valid?
      save!
      return true
    end
    return false
  end

  def save!
    ActiveRecord::Base.transaction do
      car = create_or_update_car!
      car_intake = create_or_update_car_intake!(car)
      car_intake
    end
  end

  private


  def normalize_registration
    self.car_registration = self.car_registration.upcase.strip unless self.car_registration.nil?
  end

  def create_or_update_car!
    car = Car.find_by(registration: car_registration)
    if car.present?
      car.update!(description: car_description, year: car_year)
    else
      car = Car.create!(registration: car_registration, description: car_description, year: car_year)
    end
    car
  end

  def create_or_update_car_intake!(car)
    current_car_intake = CarIntake.available.find_by(car_id: car.id)
    if current_car_intake.present?
      current_car_intake.update!(tu_carro_id: car_intake_tu_carro_id)
    else
      current_car_intake = CarIntake.create!(car: car, tu_carro_id: car_intake_tu_carro_id)
    end
    current_car_intake
  end

end