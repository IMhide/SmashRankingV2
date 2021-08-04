class Tournament < ApplicationRecord
  extend Enumerize

  validates :name, presence: true
  validates :slug, presence: true

  belongs_to :ranking, inverse_of: :tournaments
  has_many :participations, inverse_of: :tournament
  has_many :matches, inverse_of: :tournament

  enumerize :match_sync, in: %i[not_started running success failure], default: :not_started
  enumerize :tier, in: %i[none C B A S SS], default: :none
end
