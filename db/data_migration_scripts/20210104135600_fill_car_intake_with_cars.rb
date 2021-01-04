cars_to_update = Car.all
number_of_cars_to_update = cars_to_update.size
puts "Attempting to update #{number_of_cars_to_update} cars"

ActiveRecord::Base.transaction do
  cars_to_update.each_with_index do |car, index|
    puts "Attempting to create car intake for car #{index + 1} / #{number_of_cars_to_update}. car: #{car.id}, registration: #{car.registration}, tu_carro_id: #{car.tu_carro_id}"
    CarIntake.create!(car: car, tu_carro_id: car.tu_carro_id)
  end
end
