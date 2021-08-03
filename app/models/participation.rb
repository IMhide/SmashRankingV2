class Participation < ApplicationRecord
  validates :seed, presence: true
  validates :placement, presence: true
end
