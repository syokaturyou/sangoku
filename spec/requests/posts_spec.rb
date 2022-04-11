require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#show' do
    let(:post) { create(:post) }

    before do
      get public_post_path(post.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    # it '商品名が表示されているかどうか' do
    #   expect(response.body).to include post.name
    # end

    # it '説明文が表示されているかどうか' do
    #   expect(response.body).to include post.
    # end

    # it '商品の値段が表示されているかどうか' do
    #   expect(response.body).to include post.
    # end
  end
end
