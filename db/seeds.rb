user = User.find_by(email: 'nico.06.89crc@gmail.com')

if user.nil?
  User.create(
    allow_password_change: false,
    confirmation_token: "zxxZSxuEs9RhXSJCLUmn",
    confirmed_at: "2022-10-08 12:38:09.409191",
    confirmation_sent_at: "2022-10-08 12:37:58.636832",
    email: "nico.06.89crc@gmail.com",
    password: 'nicolas',
    password_confirmation: 'nicolas',
  )
end

Property.destroy_all
icons = ["AccessibleIcon", "AdfScannerIcon", "AddchartIcon", "ArrowCircleLeftIcon", "CarRepairIcon"]

60.times do
  property = Property.create({
    title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 2),
    description: Faker::Lorem.paragraph,
    p_type: Faker::Number.between(from: 0, to: 2),
    p_status: Faker::Number.between(from: 0, to: 2),
    operating_since: Faker::Number.between(from: 1950, to: 2022).to_s,
    price: Faker::Number.within(range: 200000..3000000),
    address: Faker::Address.full_address,
    coordinates: "#{Faker::Address.latitude},#{Faker::Address.longitude}",
    sq_mts: Faker::Number.between(from: 500, to: 3000),
    bathroom_amount: Faker::Number.between(from: 1, to: 4),
    beedroom_amount: Faker::Number.between(from: 1, to: 4)
  })

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