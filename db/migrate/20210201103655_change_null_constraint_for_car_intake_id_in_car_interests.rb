class ChangeNullConstraintForCarIntakeIdInCarInterests < ActiveRecord::Migration[6.0]
  def change
    change_column_null :car_interests, :car_intake_id, false
  end
end
