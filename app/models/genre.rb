class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: {  message: '同じ名称を入力しないでください'  }

  # 検索方法分岐
  def self.looks(search, word)
    @genre = if search == 'partial_match'
               Genre.where('name LIKE?', "%#{word}%")
             else
               Genre.all
             end
  end
end
