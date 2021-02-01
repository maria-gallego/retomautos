class RemoveSuccessfullyClosedAtFromBuyProcesses < ActiveRecord::Migration[6.0]
  def change

    remove_column :buy_processes, :successfully_closed_at, :datetime
  end
end
