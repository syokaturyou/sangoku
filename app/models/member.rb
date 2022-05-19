class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

         has_many :answers, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :rates, dependent: :destroy
         has_many :member_rooms, dependent: :destroy
         has_many :chats, dependent: :destroy
         has_many :sights, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :evaluates, dependent: :destroy
         has_many :liked_sights, through: :likes, source: :sight
         has_many :sns_credentials, dependent: :destroy


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

  # ゲストログイン
   def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = 'guest'
      member.profile = 'ゲストユーザーです。お気軽にお試しください'
    end
   end

  # APIからログイン
  # def self.without_sns_data(auth)
  #   member = Member.where(email: auth.info.email).first

  #     if member.present?
  #       sns = SnsCredential.create(
  #         mid: auth.mid,
  #         provider: auth.provider,
  #         member_id: member.id
  #       )
  #     else
  #       member = Member.new(
  #         name: auth.info.name,
  #         email: auth.info.email,
  #         password: SecureRandom.urlsafe_base64,
  #       )
  #       sns = SnsCredential.new(
  #         mid: auth.mid,
  #         provider: auth.provider
  #       )
  #     end
  #     return { member: member ,sns: sns}
  # end

  # def self.with_sns_data(auth, snscredential)
  #   member = Member.where(id: snscredential.member_id).first
  #   unless member.present?
  #     member = Member.new(
  #       name: auth.info.name,
  #       email: auth.info.email,
  #       password: SecureRandom.urlsafe_base64,
  #     )
  #   end
  #   return {member: member}
  # end

  # def self.find_oauth(auth)
  #   mid = auth.mid
  #   provider = auth.provider
  #   snscredential = SnsCredential.where(mid: mid, provider: provider).first
  #   if snscredential.present?
  #     member = with_sns_data(auth, snscredential)[:member]
  #     sns = snscredential
  #   else
  #     member = without_sns_data(auth)[:member]
  #     sns = without_sns_data(auth)[:sns]
  #   end
  #   return { member: member ,sns: sns}
  # end

   def self.from_omniauth(auth)
    where(provider: auth.provider, mid: auth.mid).first_or_create do |member|
      # deviseのuserカラムに name を追加している場合は以下のコメントアウトも追記します
      member.id = 16
      member.name = auth.info.name
      member.email = auth.info.email
      member.password = Devise.friendly_token[0,20]
    end
   end

end
