class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # 外部API認証用に追加 現在はツイッターのみ
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

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

   def self.find_for_oauth(auth)
       member = Member.find_by(uid: auth.uid, provider: auth.provider).first

       member ||= Member.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        encrypted_password: Devise.friendly_token[0, 20],
        name: auth.info.name,
      )
   end

  #   member
  # end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end


