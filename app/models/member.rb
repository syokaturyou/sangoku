class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :answers, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :rates, dependent: :destroy

     def active_for_authentication?
        super && (self.is_deleted == false)
     end

   # 検索方法分岐
   def self.looks(search, word)
    if search == "perfect_match"
      @member = Member.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @Member = Member.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @member = Member.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @member = Member.where("name LIKE?","%#{word}%")
    else
      @member = Member.all
    end
   end


end
