class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # Twitter認証用に追加したが廃止
#          :omniauthable, omniauth_providers: [:twitter]

#  def self.from_omniauth(auth)
#       where(provider: auth.provider, uid: auth.uid).first_or_create do |member|
#       member.uid = auth.uid,
#       member.provider = auth.provider,
#       member.name = auth.info.name,
#     #   member.email = User.dummy_email(auth),
#       member.encrypted_password = Devise.friendly_token[0, 20]
#       member.save
#     end
#  end

#   # ダミーのメールアドレスを作成
#   def self.dummy_email(auth)
#     "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
#   end

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


