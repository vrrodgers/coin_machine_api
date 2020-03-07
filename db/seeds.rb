
User.create!(
  first_name: "strawberry",
  last_name: "shortcake",
  email: Faker::Internet.email,
  admin: true
  ) 
  puts "admin user created"


User.create!(
    first_name: "blueberry",
    Last_name: "muffin",
    email: Faker::Internet.email,
    admin: true

  )
puts "admin user was created"

4.times do |user|
  User.create!(
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :email => Faker::Internet.email
  )
end
puts "4 user created"

@coins = ["penny", "nickel", "dime"]

@coins.each do | coin |
  Coin.create!(
    name: coin,
    value: 10
  )
  puts "10 " + coin + " created"
end
