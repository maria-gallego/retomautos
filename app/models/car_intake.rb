class CarIntake < ApplicationRecord
  # Associations
  # ========================
  belongs_to :car
  belongs_to :car_sale, optional: true

  # Scopes
  # ========================
  scope :available, -> { where(car_sale_id: nil) }
  scope :car_registration_contains, ->(registration) { joins(:car).merge(Car.registration_contains(registration)) }
  scope :car_year_from, ->(year) { joins(:car).merge(Car.year_from(year)) }
  scope :car_year_to, ->(year) { joins(:car).merge(Car.year_to(year)) }

end
