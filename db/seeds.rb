30.times do |n|
  name = Faker::GreekPhilosophers.name
  email = Faker::Internet.email
  password = Faker::Alphanumeric.alphanumeric(number: 10)
  title = Faker::Fantasy::Tolkien.character
  content = Faker::Quotes::Shakespeare.hamlet_quote
  user = User.create!(name: name,
              email: email,
              password: password)
  Task.create!(title: title, content: content, user: user)
end