require 'rails_helper'

RSpec.describe 'Members', type: :request do
  describe 'GET public/members#show' do
    let(:member) { create(:member) }

    before do
      get public_member_path(member.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '名前が表示されているかどうか' do
      expect(response.body).to include member.name
      expect(response.body).to include member.profile
    end
  end
end
