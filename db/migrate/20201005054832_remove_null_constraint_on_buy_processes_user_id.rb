class RemoveNullConstraintOnBuyProcessesUserId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :buy_processes, :user_id, true
  end
end
