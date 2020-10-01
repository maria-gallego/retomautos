class CreateBuyProcesses < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_processes do |t|
      t.datetime :successfully_closed_at
      t.datetime :unsuccessfully_closed_at
      t.string :source
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
