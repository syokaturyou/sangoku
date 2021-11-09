class MembersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @member = members(:john)

    # OmniAuth configuration
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123456',
      info: { email: 'john@example.com', name: 'John English' }
    )
  end

  test 'login and logout with twitter account' do
    get new_member_session_path
    assert_select 'form[action=?]', member_twitter_omniauth_authorize_path
    post '/members/auth/twitter', params: OmniAuth.config.mock_auth[:twitter]
    assert_redirected_to '/members/auth/twitter/callback'
    follow_redirect!
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', destroy_member_session_path
    delete destroy_member_session_path
    assert_nil session[:member_id]
  end
end