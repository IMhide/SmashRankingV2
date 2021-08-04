class Participation < ApplicationRecord
  validates :seed, presence: true
  validates :placement, presence: true

  belongs_to :player, inverse_of: :participations
  belongs_to :tournament, inverse_of: :participations
end
