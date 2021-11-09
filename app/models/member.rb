class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # 外部API認証用に追加 現在はツイッターのみ
         :omniauthable, omniauth_providers: [:twitter]

  def self.find_for_oauth(auth)
    member = Member.find_by(uid: auth.uid, provider: auth.provider)

    member ||= Member.create!(
      uid: auth.uid,
      provider: auth.provider,
      name: auth[:info][:name],
      email: User.dummy_email(auth),
      encrypted_password: Devise.friendly_token[0, 20]
    )

    member
  end

  # ダミーのメールアドレスを作成
  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end

         has_many :answers, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :rates, dependent: :destroy
         has_many :member_rooms, dependent: :destroy
         has_many :chats, dependent: :destroy

         attachment :profileimage

     def active_for_authentication?
        super && (self.is_deleted == false)
     end

   # 検索方法分岐
   def self.looks(search, word)
   @member = if search == "partial_match"
              Member.where("name LIKE?","%#{word}%")
             else
              Member.all
             end
   end


end


