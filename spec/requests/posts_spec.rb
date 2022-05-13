require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#show' do
    # let(:posts) { create_list(:post, 4) }
    # let(:image) { create(:image) }
    # let(:genre) { create(:genre, name: 'genre') }
    # let(:member) { create(:member, name: 'member', email: '1@1') }
    # let(:post) { create(:post, genres: [genre], members: [member]) }
    # let(:posts) { create_list(:post, 5, genres: [genre], members: [member]) }

    before do
      post.images << image
      posts.each { |post| post.images << create(:image) }
      get public_post_path(post.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      expect(response.body).to include post.posttitle
    end
  end
end
