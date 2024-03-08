# db/seeds.rb

User.destroy_all

5000.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: 'sherry123',
    password_confirmation: 'sherry123'
  )
end

puts "Created 5,000 dummy users with password set to 'sherry123'."
