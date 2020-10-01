class CarInterestInquiry < ApplicationRecord

  # Associations
  # ========================
  belongs_to :car_interest


  # Validations
  # ========================
  validates :body, presence: true

end
