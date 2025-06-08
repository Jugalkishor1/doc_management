# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

super_admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "password"
  user.role = :super_admin
end

manager = User.find_or_create_by!(email: "manager@example.com") do |user|
  user.password = "password"
  user.role = :manager
  user.manager = super_admin
end

supervisor = User.find_or_create_by!(email: "supervisor@example.com") do |user|
  user.password = "password"
  user.role = :supervisor
  user.manager = manager
end

deo = User.find_or_create_by!(email: "deo@example.com") do |user|
  user.password = "password"
  user.role = :data_entry_operator
  user.manager = manager
  user.supervisor = supervisor
end

client = User.find_or_create_by!(email: "client@example.com") do |user|
  user.password = "password"
  user.role = :client
  user.manager = manager
  user.supervisor = supervisor
  user.data_entry_operator = deo
end
