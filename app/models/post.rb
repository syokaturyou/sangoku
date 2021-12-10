class Post < ApplicationRecord

  is_impressionable counter_cache: true # 閲覧数確認のため記載

  belongs_to :member
  belongs_to :genre
  has_many :answers, dependent: :destroy

  attachment :postimage

  # 質問一覧画面で回答数0を見つける際に使用
  scope :recent, -> { left_joins(:answers).where(answers: {member_id: nil}).order(updated_at: 'DESC') }

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @post = Post.where("posttitle LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
