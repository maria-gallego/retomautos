class AddCarIntakeToCarSales < ActiveRecord::Migration[6.0]
  def change
    add_reference :car_sales, :car_intake, null: false, foreign_key: true
  end
end
