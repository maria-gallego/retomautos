class CarIntake < ApplicationRecord
  # Associations
  # ========================
  belongs_to :car
  has_one :car_sale

  # Scopes
  # ========================
  scope :available, -> { left_outer_joins(:car_sale).where(car_sales: {id: nil}) }
  scope :car_registration_contains, -> (registration) { joins(:car).merge(Car.registration_contains(registration)) }
  scope :car_year_from, -> (year) { joins(:car).merge(Car.year_from(year)) }
  scope :car_year_to, -> (year) { joins(:car).merge(Car.year_to(year)) }
  scope :available_for_buy_process, -> (buy_process) do
    car_intakes_in_buy_process = buy_process.car_interests.pluck(:car_intake_id)
    available.where.not(id: car_intakes_in_buy_process)
  end

  # Instance Methods
  # ===============================
  delegate :description, :year, to: :car, prefix: true

end
