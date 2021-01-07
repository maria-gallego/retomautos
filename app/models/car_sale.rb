class CarSale < ApplicationRecord
  belongs_to :buy_process
  belongs_to :car_intake
end
