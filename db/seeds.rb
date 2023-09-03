# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Room.destroy_all

['Large Double', 'Small Double', 'Single Room', 'Sitting Room', 'Other'].each do |room_name|
  Room.create!(name: room_name)
end
