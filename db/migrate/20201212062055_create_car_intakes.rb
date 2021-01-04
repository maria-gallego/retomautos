class CreateCarIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :car_intakes do |t|
      t.references :car, null: false, foreign_key: true
      t.references :car_sale, null: true, foreign_key: true

      t.timestamps
    end
  end
end
