describe Car do
  context 'scopes' do
    let!(:car_1) { Car.create!(description: 'car_1', year: 2000, registration: 'ABC123') }
    let!(:car_2) { Car.create!(description: 'car_2', year: 2005, registration: 'DEF123') }
    let!(:car_3) { Car.create!(description: 'car_3', year: 2007, registration: 'GHI567') }

    describe ".registration_contains" do
      context "when there are cars with registrations containing" do
        it "finds cars with registration containing numbers" do
          cars_found = Car.all.registration_contains(123)
          expect(cars_found.size).to eq(2)
          expect(cars_found).to include(car_1, car_2)
        end

        it "finds cars with registration containing letters" do
          cars_found = Car.all.registration_contains('DEF')
          expect(cars_found.size).to include(car_2)
        end
      end

      context "when there are no cars with registration containing" do
        it "does not find car registration containing" do
          cars_found = Car.all.registration_contains('678')
          expect(cars_found.size).to eq(0)
        end
      end
    end

    describe "cars with year from and year to" do

      context "when there are cars in the desired years" do
        it "finds car with desired from year" do
          resulting_cars = Car.all.year_from(2005).pluck(:registration)

          expect(resulting_cars[0]).to eq(car_2.registration)
          expect(resulting_cars[1]).to eq(car_3.registration)
        end

        it "finds car with desired to year" do
          resulting_cars = Car.all.year_to(2005).pluck(:registration)

          expect(resulting_cars[0]).to eq(car_1.registration)
          expect(resulting_cars[1]).to eq(car_2.registration)
        end
      end

      context "when there are no cars in desired years" do
        it "does not find cars from desired year" do
          resulting_cars = Car.all.year_from(2008)
          expect(resulting_cars.size).to eq(0)
        end

        it "does not find cars to desired year" do
          resulting_cars = Car.all.year_to(1999)
          expect(resulting_cars.size).to eq(0)
        end
      end
    end
  end
end