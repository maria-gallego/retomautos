class Car < ApplicationRecord
  # Validations
  # ========================
  validates :description, presence: true
  validates :year, presence: true
  validates :registration, presence: true, format: { with: /\A[A-Z]{3}\d{3}\z/,
                                                     message: "debe seguir el formato ABC123" }

  # Associations
  # ========================
  has_many :car_interests

  # Callbacks
  # ========================
  before_validation :normalize_registration

  # Scopes
  # ========================
  scope :find_by_registration, -> (registration) { find_by(registration: registration.upcase.strip) }

  # Class Methods
  # ========================
  def self.create_or_update_by_registration!(car_attributes)
    registration = car_attributes.fetch(:registration)
    car = Car.find_by(registration: registration)
    if car.present?
      car.update!(**car_attributes)
    else
      car = Car.create!(**car_attributes)
    end
    car
  end

  private

  def normalize_registration
    self.registration = self.registration.upcase.strip unless self.registration.nil?
  end
end
