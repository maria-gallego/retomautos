class CarSale < ApplicationRecord
  belongs_to :buy_process
  has_one :car_intake
end
