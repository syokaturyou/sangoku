class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def twitter
    callback_for(:twitter)
  end

  def rakuten
    callback_for(:rakuten)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = Member.find_oauth(@omniauth)
    @member = info[:member]
    if @member.persisted?
      sign_in_and_redirect @member, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      @sns = info[:sns]
      render template: 'devise/registrations/new'
    end
  end

  def failure
    redirect_to root_path
  end
end
