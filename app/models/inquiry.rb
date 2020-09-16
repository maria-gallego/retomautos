class Inquiry < ApplicationRecord

  # Associations
  # ========================
  belongs_to :client

  # Validations
  # ========================
  validates :body, presence: true

end
