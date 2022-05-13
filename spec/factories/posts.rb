FactoryBot.define do
 factory :post do
    member_id { 1 }
    genre_id { 1 }
    posttitle { 'MyString' }
    postbody { 'MyString' }
    postsyutten { 'MyString' }
    postimage_id { 'MyString' }
    score {  }
    impressions_count { 1 }
  end
end