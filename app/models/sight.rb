class Sight < ApplicationRecord
  belongs_to :member
  has_many :evaluates, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_members, through: :likes, source: :member

  geocoded_by :address
  after_validation :geocode

  attachment :mapimage

  def liked?(member)
    likes.where(member_id: member.id).exists?
  end
end
