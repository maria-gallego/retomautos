class CreateCarSales < ActiveRecord::Migration[6.0]
  def change
    create_table :car_sales do |t|
      t.references :buy_process, null: false, foreign_key: true

      t.timestamps
    end
  end
end
