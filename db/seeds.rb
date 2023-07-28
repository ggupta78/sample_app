# Create the main sample user
puts 'Adding admin...'
User.create!(name: 'Example User', email: 'example@railstutorial.org',
             password: 'password', password_confirmation: 'password',
             admin: true)

puts 'Generating 99 other users...'
# Generate 99 other users
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'

  User.create!(name: name, email: email, password: password,
               password_confirmation: password)
  puts "User #{name} with email #{email} added!"
end
