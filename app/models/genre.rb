class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true

   # 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @genre = Genre.where("name LIKE?","%#{word}%")
    else
      @genre = Genre.all
    end
  end

end
