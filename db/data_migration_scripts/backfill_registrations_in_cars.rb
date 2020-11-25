cars_to_update = Car.where(registration: nil).order(created_at: :asc)
number_of_cars_to_update = cars_to_update.size
number_of_duplicates = 0

ActiveRecord::Base.transaction do
  cars_to_update.each_with_index do |car, index|
    puts "Attempting to update car #{index + 1} / #{number_of_cars_to_update}. car: #{car.id}, tu_carro_id: #{car.tu_carro_id}"

    # 1. Pedir la info del carro a meli utilizando el tu_carro_id
    remote_cars_repo = AskQuestionTuCarro::RemoteRepositories::TuCarroCarsRepo.new
    remote_car = remote_cars_repo.find_by_id!(car.tu_carro_id)

    pre_existing_car = Car.find_by(registration: remote_car.registration)

    if pre_existing_car.present?
      number_of_duplicates = number_of_duplicates + 1
      puts "Duplicated car detected"
      puts "pre_existing_car info - id: #{pre_existing_car.id}, tu_carro_id: #{pre_existing_car.tu_carro_id}"
      puts "current_car info - id: #{car.id}, tu_carro_id: #{car.tu_carro_id}"
      puts "Duplicated Registration: #{remote_car.registration}"

      # get all car interest of pre-existing car
      pre_existing_car_interests = pre_existing_car.car_interests
      # change car_id to current car
      pre_existing_car_interests.each { |car_interest| car_interest.update!(car_id: car.id) }
      # delete pre-existing car
      pre_existing_car.destroy!
    end

    # 2. Actualizar el registration en la base de datos con base en la info de meli
    car.update!(registration: remote_car.registration)
  end
end

puts "All cars updated"
puts "Found #{number_of_duplicates} duplicates"

