class Post < ApplicationRecord

  is_impressionable # 閲覧数確認のため追加

  belongs_to :member
  belongs_to :genre
  has_many :answers, dependent: :destroy

  attachment :postimage

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @post = Post.where("posttitle LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
