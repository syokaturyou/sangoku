FactoryBot.define do
  factory :answer do
    member_id { 1 }
    post_id { 1 }
    answerbody { 'MyString' }
    answersyutten { 'MyString' }
    answerimage_id { 'MyString' }
    score { 1 }
  end
end
