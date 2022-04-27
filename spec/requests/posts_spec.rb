require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#index' do
    # let(:post) { create(:post) }
    let(:posts) { create_list(:post, 4) }
    # let(:image) { create(:image) }

    before do
      # post.images << image
      get public_posts_path
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      posts.all? do |post|
        expect(response.body).to include post.posttitle
      end
    end
  end
end
