# Create the main sample user
puts 'Adding admin...'
User.create!(name: 'Example User', email: 'example@railstutorial.org',
             password: 'password', password_confirmation: 'password',
             admin: true, activated: true, activated_at: Time.zone.now)

puts 'Generating 99 other users...'
# Generate 99 other users
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'

  User.create!(name: name, email: email, password: password,
               password_confirmation: password,
               activated: true, activated_at: Time.zone.now)

  puts "User #{name} with email #{email} added!"
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Create relationships
users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
