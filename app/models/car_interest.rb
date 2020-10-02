class CarInterest < ApplicationRecord
  belongs_to :buy_process
  belongs_to :car
  has_many :car_interest_inquiries
end
