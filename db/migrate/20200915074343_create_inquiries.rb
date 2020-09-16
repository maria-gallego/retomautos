class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.text :body
      t.string :car
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
    add_index :inquiries, [:created_at]
  end
end
