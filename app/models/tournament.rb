class Tournament < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true

  belongs_to :ranking, inverse_of: :tournaments
  has_many :participations, inverse_of: :tournament
end
