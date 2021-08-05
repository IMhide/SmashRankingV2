class Ranking < ApplicationRecord
  extend Enumerize

  validates :name, presence: true

  has_one :tier_list, inverse_of: :ranking
  has_many :tournaments, inverse_of: :ranking

  enumerize :compute_state, in: %i[not_started running success failure], default: :not_started
end
