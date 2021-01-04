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
  has_many :car_intakes

  # Scope
  # ========================
  scope :registration_contains, ->(registration) { where("cars.registration ILIKE ?", "%#{registration}%") }
  scope :year_from, -> year {where('cars.year >= ?', year)}
  scope :year_to, -> year {where('cars.year <= ?', year)}


  def registration_and_description
    "#{registration || 'N/A'} - #{description}"
  end


  # Class Methods
  # ========================

end
