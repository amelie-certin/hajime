# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
image_path = 'app/assets/images'
characters = [
  { name: 'Grumpy cat', legs: 4, arms: 0, avatar: File.open("#{image_path}/Grumpy cat.png") },
  { name: 'Arthur', legs: 2, arms: 2, avatar: File.open("#{image_path}/Arthur.png") },
  { name: 'Doggo', legs: 4, arms: 0, avatar: File.open("#{image_path}/Doggo.jpg") },
  { name: 'Nyan cat', legs: 2, arms: 2, avatar: File.open("#{image_path}/Nyan cat.jpeg") },
  { name: 'Lamasticot', legs: 0, arms: 0, avatar: File.open("#{image_path}/Lamasticot.jpg") }
]

weapons = Weapon.create [
  { name: 'Scratch', arms: 0, legs: 2, focus: 11, power: 24 },
  { name: 'Excalibur', arms: 2, legs: 0, focus: 15, power: 28 },
  { name: 'Wouf', arms: 0, legs: 4, focus: 2, power: 11 },
  { name: 'Rocket', arms: 2, legs: 2, focus: 25, power: 34 },
  { name: 'Dig', arms: 0, legs: 0, focus: 20, power: 31 }
]

characters.each_with_index do |character, i|
  character[i] = Character.new character
  character[i].random
  character[i].save
  character[i].weapons << weapons[i]
end
