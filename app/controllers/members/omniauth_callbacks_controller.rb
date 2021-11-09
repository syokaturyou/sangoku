# frozen_string_literal: true

class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  # def facebook

  #   # Facebook上でメール使用を許可しているかの分岐
  #   if request.env['omniauth.auth'].info.email.blank?
  #     redirect_to '/members/auth/facebook?auth_type=rerequest&scope=email'
  #   end

  # # member.from_omniauthはModel側で実装
  #   member = Member.from_omniauth(request.env['omniauth.auth'])

  #   # すでにmemberが登録済みかの判定
  #   if member
  #     # 登録済みならログイン
  #     sign_in_and_redirect member, event: :authentication
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     # 新規登録用にセッションに必要情報を格納
  #     if (data = request.env['omniauth.auth'])
  #       session['devise.omniauth_data'] = {
  #           email: data['info']['email'],
  #           provider: data['provider'],
  #           uid: data['uid']
  #       }
  #     end
  #       redirect_to new_member_registration_url
  #   end
  # end


    # def failure
    # redirect_to root_path
    # end

    # コメントアウト外して、処理追加(8行目あたり)
    def twitter
    callback_from :twitter
    end

  # 最後のendの直前に記載
    private

  # コールバック時に行う処理
   def callback_from(provider)
     provider = provider.to_s
     @member = Member.find_for_oauth(request.env['omniauth.auth'])

    # persisted?でDBに保存済みかどうか判断
    if @member.persisted?
      # サインアップ時に行いたい処理があればここに書きます。
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @member, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_member_registration_url
    end
   end

end
