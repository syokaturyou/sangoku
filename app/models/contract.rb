class Contract < ApplicationRecord
  #問い合わせ内容のメッセージに関して必須にしておく。
  validates :message, presence: true
end
