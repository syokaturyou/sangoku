FactoryBot.define do
  factory :member do
    name { 'MyString' }
    sequence(:email) { |n| "MyString#{n}@example.com" }
    profile { 'MyString' }
    is_deleted { 'MyString' }
    password { '111111' }
  end
end
