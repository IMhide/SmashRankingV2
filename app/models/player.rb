class Player < ApplicationRecord
  validates :name, presence: true
  validates :remote_id, presence: true

  has_many :participations, inverse_of: :player
  has_many :matches_won, class_name: 'Match', foreign_key: 'winner_id'
  has_many :matches_lost, class_name: 'Match', foreign_key: 'looser_id'
  has_many :ratings, inverse_of: :player
  has_many :tournaments, through: :participations

  def display_name
    [team, name].compact.join(' | ')
  end

  def previous_tournament_for(ranking_id:, tournament:)
    tournaments.where('tournaments.ranking_id = ? AND dated_at < ?', ranking_id, tournament.dated_at).order(dated_at: :desc).first
  end
end
