User.create(
  allow_password_change: false,
  confirmation_token: "zxxZSxuEs9RhXSJCLUmn",
  confirmed_at: "2022-10-08 12:38:09.409191",
  confirmation_sent_at: "2022-10-08 12:37:58.636832",
  email: "nico.06.89crc@gmail.com",
  password: 'AAEERRaaa!@2022',
  password_confirmation: 'AAEERRaaa!@2022',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  phone_number: Faker::PhoneNumber.cell_phone_in_e164,
  address: Faker::Address.full_address,
  date_of_birth: Faker::Date.in_date_period(year: 1989),
  gender: Faker::Gender.type,
  user_role: 0
)

User.create(
  allow_password_change: false,
  confirmation_token: "3aBLRD83QTuJJsiokGZz",
  confirmed_at: "2022-10-16 11:34:28.726967",
  confirmation_sent_at: "2022-10-16 11:32:51.9347",
  email: "nico0689crcde@gmail.com",
  password: 'AAEERRaaa!@2022',
  password_confirmation: 'AAEERRaaa!@2022',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  phone_number: Faker::PhoneNumber.cell_phone_in_e164,
  address: Faker::Address.full_address,
  date_of_birth: Faker::Date.in_date_period(year: 1989),
  gender: Faker::Gender.type,
  user_role: 1
)

icons = ["AccessibleIcon", "AdfScannerIcon", "AddchartIcon", "ArrowCircleLeftIcon", "CarRepairIcon"]

5.times.with_index do |index_real_estate|
  # Creating The Real Estate Agency
  real_estate = RealEstate.create({
    name: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 2),
    description: Faker::Lorem.paragraph,
    contact_phone: Faker::PhoneNumber.cell_phone_in_e164,
    contact_email: Faker::Internet.email,
    address: Faker::Address.full_address
  })

  # Creating The Real Estate Agency Administrator
  RealEstateUser.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    address: Faker::Address.full_address,
    date_of_birth: Faker::Date.in_date_period(year: 1989),
    gender: Faker::Gender.type,
    user_role: 2,
    email: "admin_#{index_real_estate+1}@realestate.com",
    password: 'AAEERRaaa!@2022',
    password_confirmation: 'AAEERRaaa!@2022',
    real_estate: real_estate,
    real_estate_responsible: real_estate
  })

  # Creating The Real Estate Agency Agent 1
  5.times.with_index do |index_agent|
    agent = RealEstateUser.create({
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: Faker::PhoneNumber.cell_phone_in_e164,
      address: Faker::Address.full_address,
      date_of_birth: Faker::Date.in_date_period(year: 1989),
      gender: Faker::Gender.type,
      user_role: 3,
      email: "agent_#{index_real_estate+1}_#{index_agent+1}@realestate.com",
      password: 'AAEERRaaa!@2022',
      password_confirmation: 'AAEERRaaa!@2022',
      real_estate: real_estate,
      real_estate_responsible: real_estate
    })

    rand(1..10).times do
      property = Property.create!({
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
        beedroom_amount: Faker::Number.between(from: 1, to: 4),
        user: agent,
        real_estate: real_estate
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
  end
end