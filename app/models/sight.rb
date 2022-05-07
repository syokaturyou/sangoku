class Sight < ApplicationRecord
  belongs_to :member

  geocoded_by :address
  after_validation :geocode

  attachment :mapimage
end
