class Player < ApplicationRecord
  validates :name, presence: true
  validates :remote_id, presence: true

  has_many :participations, inverse_of: :player
  has_many :match_won, class_name: 'Match', foreign_key: 'winner_id'
  has_many :match_lost, class_name: 'Match', foreign_key: 'looser_id'

  def display_name
    [team, name].compact.join(' | ')
  end
end
