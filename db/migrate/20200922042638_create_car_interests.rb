class CreateCarInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :car_interests do |t|
      t.references :buy_process, null: false, foreign_key: true

      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
