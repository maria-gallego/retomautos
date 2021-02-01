class RemoveCarIdFromCarInterests < ActiveRecord::Migration[6.0]
  def change
    remove_reference :car_interests, :car, null: false, foreign_key: true
  end
end
