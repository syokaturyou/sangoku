class Post < ApplicationRecord

  is_impressionable counter_cache: true # 閲覧数確認のため記載

  belongs_to :member
  belongs_to :genre
  has_many :answers, dependent: :destroy

  attachment :postimage

  # scope :featured, order('member_ids_count DESC')
  scope :recent, -> { joins(:answers).order('count(member_id) desc').group("answers.post_id").order(created_at: :desc) }

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @post = Post.where("posttitle LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
