class Car < ApplicationRecord
  # Validations
  # ========================
  validates :description, presence: true
  validates :year, presence: true

  # Associations
  # ========================
  has_many :car_interests

  ## Class Methods
  ## ========================
  def self.create_or_update_by_tu_carro_id!(car_attributes)
    tu_carro_id = car_attributes.fetch(:tu_carro_id)
    car = Car.find_by(tu_carro_id: tu_carro_id)
    if car.present?
      car.update!(**car_attributes)
    else
      car = Car.create!(**car_attributes)
    end
    car
  end
end
