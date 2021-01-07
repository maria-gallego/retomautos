class CarSale < ApplicationRecord
  belongs_to :buy_process
  belongs_to :car_intake

  # Scope
  # ========================
  scope :sold_at_date_from, -> date {where('car_sales.created_at >= ?', date.to_date.beginning_of_day)}
  scope :sold_at_date_to, -> date {where('car_sales.created_at <= ?', date.to_date.end_of_day)}
end
