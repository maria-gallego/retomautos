class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :user,  foreign_key: true

      t.timestamps
    end
    add_index :clients, [:created_at]

  end
end
