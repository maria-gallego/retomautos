class CreateCarInterestInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :car_interest_inquiries do |t|
      t.text :body
      t.references :car_interest, null: false, foreign_key: true

      t.timestamps
    end
    add_index :car_interest_inquiries, [:created_at]
  end
end
