# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

Tool.destroy_all
puts "Destroyed all tools"
User.destroy_all
puts "Destroyed all users"

user = User.create!(email: "test@mail.com", password: "123456")
puts "Created one user"

file1 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686057/zfede2z6jtf44gmszjou.webp").open
tool1 = Tool.create!(
  name: "Hammer",
  description: "Standard claw hammer for general carpe try.",
  tool_price: 10.00,
  condition: "good",
  user: user
)
tool1.photo.attach(io: file1, filename: "hammer.webp")
tool1.save

file2 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686067/ebtcllzclojvclgkxsgb.png").open
tool2 = Tool.create!(
  name: "Hand Saw",
  description: "14-inch wood cutting hand saw.",
  tool_price: 7.50,
  condition: "fair",
  user: user
)
tool2.photo.attach(io: file2, filename: "handsaw.png")
tool2.save

file3 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686114/hkvkreuzznlhzllpp0e6.avif").open
tool3 = Tool.create!(
  name: "Paint Roller",
  description: "9-inch roller with replaceable sleeves.",
  tool_price: 5.00,
  condition: "excellent",
  user: user
)
tool3.photo.attach(io: file3, filename: "paint-roller.avif")
tool3.save

file4 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686425/iwmfh3efkuoywzwzxbo9.avif").open
tool4 = Tool.create!(
  name: "Toolbox",
  description: "Durable plastic toolbox with metal latches.",
  tool_price: 15.00,
  condition: "new",
  user: user
)
tool4.photo.attach(io: file4, filename: "toolbox.avif")
tool4.save

file5 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745685999/athzqnanklqvzvjumwpg.avif").open
tool5 = Tool.create!(
  name: "Cordless Drill",
  description: "High-performance drill with extra battery.",
  tool_price: 25.00,
  condition: "good",
  user: user
)
tool5.photo.attach(io: file5, filename: "drill.avif")
tool5.save

file6 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686415/f6ivpa6oor4fy8wolvps.png").open
tool6 = Tool.create!(
  name: "Extension Cord",
  description: "25-foot heavy-duty outdoor extension cord.",
  tool_price: 4.00,
  condition: "excellent",
  user: user
)
tool6.photo.attach(io: file6, filename: "tool-default.png")
tool6.save

puts "Created six tools"
