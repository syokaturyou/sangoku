FactoryBot.define do
  factory :post do
    member_id { 1 }
    genre_id { 1 }
    posttitle { 'MyString' }
    postbody { 'MyString' }
    postsyutten { 'MyString' }
    postimage_id { 'MyString' }
    score { 1 }
    impressions_count { 1 }
    # association :member
    # association :genre
  end
end
