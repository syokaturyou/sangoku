class Members::OmniauthCallbacksController < ApplicationController

  def twitter
    callback_from :twitter
  end

  def failure
    redirect_to new_member_registration_url
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @member = Member.find_or_create_from_auth(request.env['omniauth.auth'].except('extra'))

    if @member.persisted? # DBに保存済みかどうかを判定
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @member, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_member_session_url
    end
  end
end
