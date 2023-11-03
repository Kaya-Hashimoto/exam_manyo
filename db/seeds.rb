30.times do |n|
  name = Faker::GreekPhilosophers.name
  email = Faker::Internet.email
  password = Faker::Alphanumeric.alphanumeric(number: 10)
  User.create!(name: name,
              email: email,
              password: password)
end