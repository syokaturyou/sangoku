FactoryBot.define do
  factory :sight do
    member_id { 1 }
    address { 'MyString' }
    profile { 'MyString' }
    mapimage_id { 'MyString' }
    latitude { 1.0 }
    longitude { 1.0 }
    # association :member
  end
end
