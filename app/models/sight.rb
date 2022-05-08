class Sight < ApplicationRecord
  belongs_to :member
  has_many :evaluates, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

  attachment :mapimage
end
