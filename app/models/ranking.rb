class Ranking < ApplicationRecord
  validates :name, presence: true

  has_one :tier_list, inverse_of: :ranking
end
