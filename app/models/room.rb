class Room < ApplicationRecord
  has_many :member_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end
