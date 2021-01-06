class CarInterest < ApplicationRecord
  # Validations
  # ========================
  belongs_to :buy_process
  belongs_to :car
  belongs_to :car_intake
  validates :buy_process_id, uniqueness: { scope: :car_id }

  # Associations
  # ========================
  has_many :car_interest_inquiries, dependent: :destroy

  # Class Methods
  # ========================
  def self.find_or_create_for!(buy_process:, car_intake:)
    existing_car_interest = CarInterest.find_by(buy_process_id: buy_process.id, car_intake: car_intake.id)
    return existing_car_interest if existing_car_interest.present?

    create!(buy_process: buy_process, car_intake: car_intake)
  end
end
