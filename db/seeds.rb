# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create Customers
5.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address
  )
end

# Create Teas
10.times do
  Tea.create(
    title: Faker::Tea.variety,
    description: Faker::Tea.type,
    temperature: Faker::Number.between(from: 150, to: 212),
    brew_time: Faker::Number.between(from: 1, to: 5)
  )
end
