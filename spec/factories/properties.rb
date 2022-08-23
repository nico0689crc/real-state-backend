FactoryBot.define do
  factory :property do
    title { "MyString" }
    description { "MyText" }
    property_type { 1 }
    status { 1 }
    operating_since { "MyString" }
    price { 1.5 }
    address { "MyString" }
    coordinates { "MyString" }
    facilities { "MyText" }
    features { "MyText" }
    sq_mts { 1 }
  end
end
