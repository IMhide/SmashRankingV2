class Rating < ApplicationRecord
  validates :base, presence: true
  validates :mean, presence: true
  validates :deviation, presence: true

  belongs_to :match, inverse_of: :ratings
  belongs_to :ranking, inverse_of: :ratings
  belongs_to :player, inverse_of: :ratings
end
