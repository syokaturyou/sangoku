require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#index' do
    # let(:post) { create(:post) }

    before do
      get public_posts_path
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end
  end
end
