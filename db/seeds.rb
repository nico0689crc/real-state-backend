# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
DatabaseCleaner.clean_with :truncation

####### PROPERTIES SEEDING - START #######
properties_array = []
icons = ["AccessibleIcon", "AdfScannerIcon", "AddchartIcon", "ArrowCircleLeftIcon", "CarRepairIcon"]

100.times do
  facilities_map = []
  features_map = []
  
  10.times do 
    facilities_map.push({ 
      "name" => Faker::House.room,
      "icon" => icons[Faker::Number.between(from: 0, to: 4)],
      "important" => Faker::Boolean.boolean(true_ratio: 0.4)
    })

    features_map.push({ 
      "name" => Faker::Construction.heavy_equipment,
      "icon" => icons[Faker::Number.between(from: 0, to: 4)],
      "important" => Faker::Boolean.boolean(true_ratio: 0.4)
    })
  end

  properties_array.push({
      title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 2),
      description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
      p_type: Faker::Number.between(from: 0, to: 2),
      p_status: Faker::Number.between(from: 0, to: 2),
      operating_since: Faker::Number.between(from: 1950, to: 2022).to_s,
      price: Faker::Number.within(range: 20.000..300.000),
      address: Faker::Address.full_address,
      coordinates: "#{Faker::Address.latitude},#{Faker::Address.longitude}",
      facilities: facilities_map.to_json,
      features: features_map.to_json,
      sq_mts: Faker::Number.between(from: 500, to: 3000)
  }) 
end 

Property.create(properties_array)
####### PROPERTIES SEEDING - END #######