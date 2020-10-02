class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :description
      t.string :tu_carro_id
      t.integer :year

      t.timestamps
    end
  end
end
