class CarInterestInquiry < ApplicationRecord

  # Associations
  # ========================
  belongs_to :car_interest


  # Validations
  # ========================
  validates :body, presence: true

  # Class Methods
  # ========================
  def self.inquiry_with_tu_carro_question_id_exists?(tu_carro_question_id)
    where(tu_carro_question_id: tu_carro_question_id).exists?
  end
end
