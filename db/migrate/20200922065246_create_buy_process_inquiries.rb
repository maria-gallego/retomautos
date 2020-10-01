class CreateBuyProcessInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_process_inquiries do |t|
      t.text :body
      t.references :buy_process, null: false, foreign_key: true

      t.timestamps
    end
  end
end
