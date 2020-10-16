
User.create!(
    name: "Maria",
    email: "mapaula08@hotmail.com",
    password: "123456789"
)
# Create 5 users
5.times do
  User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456789"
  )
end

all_user_ids = User.all.pluck(:id)
50.times do
  Client.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      user_id: all_user_ids.sample
  )
end

all_user_ids = User.all.pluck(:id)
all_client_ids = Client.all.pluck(:id)
50.times do
  BuyProcess.create!(
      source: development,
      user_id: all_user_ids.sample,
      client_id: all_client_ids.sample
  )
end
