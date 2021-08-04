class Match < ApplicationRecord
  belongs_to :winner, class_name: 'Player', inverse_of: 'matches_won'
  belongs_to :looser, class_name: 'Player', inverse_of: 'matches_lost'
  belongs_to :tournament, inverse_of: :matches

  validates :winner_score, presence: true
  validates :looser_score, presence: true
  validates :completed_at, presence: true
end
