class RemoveCarSaleFromCarIntakes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :car_intakes, :car_sale, null: true, foreign_key: true
  end
end
