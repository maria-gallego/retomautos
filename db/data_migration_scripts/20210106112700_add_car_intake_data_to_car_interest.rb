# Look for targets to update
car_interests_to_update = CarInterest.all
number_of_car_interests_to_update = car_interests_to_update.size
puts "Attempting to update #{number_of_car_interests_to_update} cars"

problematic_car_interests = []

# Update the data
ActiveRecord::Base.transaction do
  car_interests_to_update.each_with_index do |car_interest, index|
    puts "Attempting to update car intake for car_interest #{index + 1} / #{number_of_car_interests_to_update}. car_interest: #{car_interest.id} "
    car_intake_candidates = CarIntake.where(car_id: car_interest.car_id)

    # Handle edge cases
    if car_intake_candidates.size > 1
      puts "Problematic cart interest detected... Skipping car interest #{car_interest.id}"
      problematic_car_interests.push(car_interest)
    else
      car_intake = car_intake_candidates.first
      car_interest.update!(car_intake: car_intake)
    end
  end

  # Verify the data
  raise "There was a problem with the update" if CarInterest.where(car_intake_id: nil).size > 0
  CarInterest.all.each do |car_interest|
    raise "There was a problem with the update" if car_interest.car_id != car_interest.car_intake.car_id
  end
end
puts "Migration completed. #{problematic_car_interests.size} problematic car interests detected"




