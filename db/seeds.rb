# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
DatabaseCleaner.clean_with :truncation if Rails.env.development?

####### PROPERTIES SEEDING - START #######s
icons = ["AccessibleIcon", "AdfScannerIcon", "AddchartIcon", "ArrowCircleLeftIcon", "CarRepairIcon"]
images = [
  "https://themes.pixelstrap.com/sheltos/assets/images/property/1.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/2.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/3.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/4.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/5.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/6.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/7.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/8.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/9.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/10.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/11.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/12.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/13.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/14.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/15.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/16.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/17.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/18.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/19.jpg",
  "https://themes.pixelstrap.com/sheltos/assets/images/property/20.jpg"
]

138.times do

  property = Property.create({
      title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 2),
      description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
      p_type: Faker::Number.between(from: 0, to: 2),
      p_status: Faker::Number.between(from: 0, to: 2),
      operating_since: Faker::Number.between(from: 1950, to: 2022).to_s,
      price: Faker::Number.within(range: 20.000..300.000),
      address: Faker::Address.full_address,
      coordinates: "#{Faker::Address.latitude},#{Faker::Address.longitude}",
      sq_mts: Faker::Number.between(from: 500, to: 3000),
      bathroom_amount: Faker::Number.between(from: 0, to: 4),
      beedroom_amount: Faker::Number.between(from: 0, to: 4)
  })

  rand(1..10).times do
    PropertyMedia.create({
      media_path: images[Faker::Number.between(from: 0, to: 19)],
      property: property
    })
  end

  rand(1..10).times do
    PropertyAttribute.create({
      name: Faker::House.room,
      icon_name: icons[Faker::Number.between(from: 0, to: 4)],
      important: Faker::Boolean.boolean(true_ratio: 0.2),
      p_attribute_type: :feature,
      p_attribute_value: Faker::Number.between(from: 0, to: 4),
      property: property
    })
  end

  rand(1..10).times do
    PropertyAttribute.create({
      name: Faker::Construction.heavy_equipment,
      icon_name: icons[Faker::Number.between(from: 0, to: 4)],
      important: Faker::Boolean.boolean(true_ratio: 0.2),
      p_attribute_type: :facility,
      property: property
    })
  end
end 

####### PROPERTIES SEEDING - END #######