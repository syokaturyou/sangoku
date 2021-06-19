class Post < ApplicationRecord

  belongs_to :member
  has_many :answers, dependent: :destroy


  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("posttitle LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("posttitle LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("posttitle LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("posttitle LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
