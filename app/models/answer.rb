class Answer < ApplicationRecord

  belongs_to :member
  belongs_to :post
  has_many :rates, dependent: :destroy
  has_many :tags, dependent: :destroy

  attachment :answerimage
end
