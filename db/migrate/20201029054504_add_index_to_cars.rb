class AddIndexToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :registration, :string
    add_index :cars, :registration, unique: true
  end
end
