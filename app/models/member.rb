class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # 外部API認証用に追加 現在はツイッターのみ
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

  def self.from_omniauth(auth)
    where(uid: auth.uid).first
  end

  def self.new_with_session(_, session)
    super.tap do |member|
      if (data = session['devise.omniauth_data'])
        member.email = data['email'] if member.email.blank?
        member.provider = data['provider'] if data['provider'] && member.provider.blank?
        member.uid = data['uid'] if data['uid'] && member.uid.blank?
        member.skip_confirmation!
      end
    end
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


