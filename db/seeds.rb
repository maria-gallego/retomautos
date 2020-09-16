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
