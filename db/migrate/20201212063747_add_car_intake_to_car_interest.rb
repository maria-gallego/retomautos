class AddCarIntakeToCarInterest < ActiveRecord::Migration[6.0]
  def change
    add_reference :car_interests, :car_intake, null: true, foreign_key: true
  end
end
