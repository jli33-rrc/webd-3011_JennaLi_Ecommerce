# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'open-uri'

AdminUser.find_or_create_by!(email: "admin@example.com") do |u|
    u.password = "password"
    u.password_confirmation = "password"
end

# if Product.count > 10
#     puts "Removing previously seeded products, but keeping the first 10 products..."
#     Product.where("id > 10").destroy_all
# end

puts "Seeding 100 products across 4 categories..."

categories = Category.all.limit(4)
statuses = Status.all

categories.each do |category|
    25.times do
        product = Product.create!(
            product_name: Faker::Commerce.unique.product_name,
            price: Faker::Commerce.price(range: 25.0..150.0),
            description: Faker::Lorem.paragraph(sentence_count: 3),
            category: category,
            status: statuses.sample
        )

        file = URI.open("https://picsum.photos/1334/2000?random=#{rand(1..1000)}")
        product.image.attach(io: file, filename: "product_#{product.id}.jpg", content_type: "image/jpg")
    end
    puts "25 products added for #{category.category_name}"
end

puts "Finished! #{Product.count} total products in database."
puts "Note: Your 10 pre-existing products remain untouched."
