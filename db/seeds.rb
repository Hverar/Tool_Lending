# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Tool.destroy_all

user = User.create!(email: "test@mail.com", password: "123456")

Tool.create!(
  name: "Hammer",
  description: "Standard claw hammer for general carpe try.",
  tool_price: 10.00,
  condition: "good",
  user: user
)

Tool.create!(
  name: "Hand Saw",
  description: "14-inch wood cutting hand saw.",
  tool_price: 7.50,
  condition: "fair",
  user: user
)

Tool.create!(
  name: "Paint Roller",
  description: "9-inch roller with replaceable sleeves.",
  tool_price: 5.00,
  condition: "excellent",
  user: user
)

Tool.create!(
  name: "Toolbox",
  description: "Durable plastic toolbox with metal latches.",
  tool_price: 15.00,
  condition: "new",
  user: user
)

Tool.create!(
  name: "Cordless Drill",
  description: "High-performance drill with extra battery.",
  tool_price: 25.00,
  condition: "good",
  user: user
)

Tool.create!(
  name: "Extension Cord",
  description: "25-foot heavy-duty outdoor extension cord.",
  tool_price: 4.00,
  condition: "excellent",
  user: user
)
