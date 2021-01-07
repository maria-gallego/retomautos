# Look for targets to update
successfully_closed_processes = BuyProcess.where.not(successfully_closed_at: nil)
number_of_closed_processes = successfully_closed_processes.size
puts "Attempting to update #{number_of_closed_processes} successfully closed processes"

destroyed_buy_process_ids = []

ActiveRecord::Base.transaction do
  successfully_closed_processes.each_with_index do |buy_process, index|
    puts "Attempting to update buy process #{index + 1} / #{number_of_closed_processes}. buy_process: #{buy_process.id} "
    car_interest_candidates = buy_process.car_interests

    # Handling of car_interest problems
    if car_interest_candidates.size == 0
      puts "DESTROYING buy process that was closed with no car interests. #{buy_process.id}"
      destroyed_buy_process_ids.push(buy_process.id)
      buy_process.destroy!
      next
    end
    raise "The buy process #{buy_process.id} has more than one car_interest" if car_interest_candidates.size > 1

    sold_car_intake = car_interest_candidates.first.car_intake

    CarSale.create!(
        created_at: buy_process.successfully_closed_at,
        buy_process: buy_process,
        car_intake: sold_car_intake
    )
  end
end

# After migration stats
after_migration_car_sales = CarSale.all
puts "Buy processes closed before migration: #{number_of_closed_processes}"
puts "Buy processes destroyed during migration: #{destroyed_buy_process_ids.size}"
puts "Car sales after migration: #{after_migration_car_sales.size}"

