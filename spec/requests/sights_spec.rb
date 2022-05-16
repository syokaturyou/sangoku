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
      expect(response.body).to include sight.latitude.to_s
      expect(response.body).to include sight.longitude.to_s
    end
  end

  describe 'GET sights#index' do
    let(:member) { create(:member) }
    let!(:sights) { create_list(:sight, 2, member: member) }

    before do
      get sights_path
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it 'おすすめ地域情報が表示されているかどうか' do
      sights.all? do |sight|
        expect(response.body).to include sight.address
        expect(response.body).to include sight.latitude.to_s
        expect(response.body).to include sight.longitude.to_s
      end
    end
  end
end
