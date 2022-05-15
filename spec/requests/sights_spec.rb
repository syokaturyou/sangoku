require 'rails_helper'

RSpec.describe 'Sights', type: :request do
  describe 'GET sights#show' do
    let(:member) { create(:member) }
    let(:sight) { create(:sight, member: member) }

    before do
      get sight_path(sight.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '住所が表示されているかどうか' do
      expect(response.body).to include sight.address
    end

    it '緯度経度が表示されているかどうか' do
      expect(response.body).to include sight.latitude
      expect(response.body).to include sight.longitude
    end
  end

  describe 'GET sights#index' do
    # let(:sight) { create_list(:sight,5) }
    let(:member) { create(:member) }
    let(:sight) { create(:sight, member: meber) }

    before do
      # posts.images << image
      # posts.each { |post| post.images << create(:image) }
      get sights_path
      # sign_in :member
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it 'おすすめ地域情報が表示されているかどうか' do
      expect(response.body).to include '説明'
      expect(response.body).to include '投稿者'
    end
  end
end
