class CreateRoleGrants < ActiveRecord::Migration[6.0]
  def change
    create_table :role_grants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
    add_index :role_grants, [:user_id, :role_id], unique: true
  end
end
