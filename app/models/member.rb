class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :answers, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :rates, dependent: :destroy
         has_many :member_rooms, dependent: :destroy
         has_many :chats, dependent: :destroy
         has_many :sights, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :evaluates, dependent: :destroy
         has_many :liked_sights, through: :likes, source: :sight


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

   def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = 'guest'
      member.profile = 'ゲストユーザーです。お気軽にお試しください'
    end
   end
end
