class BuyProcessInquiry < ApplicationRecord

  # Validations
  # ========================
  validates :body, presence: true

  # Associations
  # ========================
  belongs_to :buy_process

end
