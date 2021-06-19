class Rate < ApplicationRecord

  belongs_to :member
  belongs_to :answer

    validates :communication, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true

  validates :source, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true

  validates :rationality, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true

  validates :intellect, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true

end
