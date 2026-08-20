# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding active records"
[
  { first_name: "Angelswing", last_name: "Korea", country: "South Korea", email: "asw@angelswing.com" },
  { first_name: "Lekhnath", last_name: "Khanal", country: "Nepal", email: "lkh@angelswing.com" },
  { first_name: "James", last_name: "Sayz", country: "Australia", email: "jas@angelswing.com" },
  { first_name: "Diego", last_name: "Fernandez", country: "Mexico", email: "diego@angelswing.com" }
].each do |user_attrs|
  User.find_or_create_by!(email: user_attrs[:email]) do |user|
    user.first_name = user_attrs[:first_name]
    user.last_name = user_attrs[:last_name]
    user.country = user_attrs[:country]
    user.password = "strong_password"
  end
end

puts "Seeded #{User.count} users"

users = User.all

contents = [
  { title: "Welcome to Rails", body: "This is my first post about learning Ruby on Rails." },
  { title: "Understanding Active Record", body: "Active Record makes database interactions simple and intuitive." },
  { title: "Building APIs", body: "APIs let different systems talk to each other over HTTP." },
  { title: "Docker for Rails Apps", body: "Containerizing a Rails app makes deployment consistent across environments." },
  { title: "JWT Authentication", body: "JSON Web Tokens are a stateless way to handle API authentication." }
]

contents.each do |content_attrs|
  Content.find_or_create_by!(title: content_attrs[:title]) do |content|
    content.body = content_attrs[:body]
    content.user = users.sample
  end
end

puts "Seeded #{Content.count} contents"
