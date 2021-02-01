class RemoveTuCarroIdFromCars < ActiveRecord::Migration[6.0]
  def change

    remove_column :cars, :tu_carro_id, :string
  end
end
