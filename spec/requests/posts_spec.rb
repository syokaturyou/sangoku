require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#show' do
    # let(:posts) { create_list(:post, 4) }
    # let(:image) { create(:image) }
    let(:genre) { create(:genre) }
    let(:member) { create(:member) }
    let(:post) { create(:post, genre:genre, member:member) }
    # let(:posts) { create_list(:post, 5, genres: [genre], members: [member]) }

    before do
      get public_post_path(post.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      expect(response.body).to include post.posttitle
    end

    it '質問文が表示されているかどうか' do
      expect(response.body).to include post.postbody
    end

    it '参考urlが表示されているかどうか' do
      expect(response.body).to include post.postsyutten
    end
  end
end
