class CarIntake < ApplicationRecord
  belongs_to :car
  belongs_to :car_sale, optional: true
end
