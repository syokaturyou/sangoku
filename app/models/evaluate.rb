class Evaluate < ApplicationRecord
  belongs_to :member
  belongs_to :sight

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true
end
