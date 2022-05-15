require 'rails_helper'

RSpec.describe 'Sights', type: :request do
  describe 'GET sights#show' do
    let(:sight) { create(:sight) }

    before do
      get sight_path(sight.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET sights#index' do
    # let(:sight) { create_list(:sight,5) }
    let(:sight) { create(:sight) }

    before do
      # posts.images << image
      # posts.each { |post| post.images << create(:image) }
      get sights_path
      # sign_in :member
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      expect(response.body).to include '質問タイトル'
    end
  end
end
