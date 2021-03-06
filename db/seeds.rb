# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: "beginners-cook@gmail.com" ,
    password: "111111"
    )

require "csv"

CSV.foreach('db/category.csv') do |row|
  Category.create(:id => row[0], :name => row[1], :ancestry => row[2])
end

CSV.foreach('db/material_detail.csv') do |row|
  MaterialDetail.create(:id => row[0], :name => row[1], :calorie => row[2], :protein => row[3], :lipids => row[4], :sugar => row[5], :dietary_fiber => row[6], :salt => row[7])
end