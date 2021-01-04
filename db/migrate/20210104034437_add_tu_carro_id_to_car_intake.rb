class AddTuCarroIdToCarIntake < ActiveRecord::Migration[6.0]
  def change
    add_column :car_intakes, :tu_carro_id, :string
  end
end
