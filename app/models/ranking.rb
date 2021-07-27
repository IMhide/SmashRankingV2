class Ranking < ApplicationRecord
  validates :name, presence: true

  has_one :tier_list, inverse_of: :ranking
  has_many :tournaments, inverse_of: :ranking
end
