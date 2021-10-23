class Tournament < ApplicationRecord
  extend Enumerize

  validates :name, presence: true
  validates :slug, presence: true

  belongs_to :ranking, inverse_of: :tournaments
  has_many :participations, inverse_of: :tournament, dependent: :destroy
  has_many :matches, inverse_of: :tournament, dependent: :destroy
  has_many :players, through: :participations

  enumerize :match_sync, in: %i[not_started running success failure], default: :not_started
  enumerize :tier, in: %i[none C B A S SS], default: :none

  def sync_status_tag_class
    {
      failure: 'no',
      success: 'yes'
    }.with_indifferent_access[match_sync]
  end

  def matches_for(player:)
    @all_matches ||= matches.where(winner: player).or(matches.where(looser: player))
  end

  def match_count_for(player:)
    all_matches = matches_for(player: player)
    matches_won = all_matches.count { |m| m.winner_id == player.id }
    matches_lost = all_matches.count { |m| m.looser_id == player.id }
    "#{matches_won} - #{matches_lost}"
  end

  def get_last_rating_for(player:)
    matches_for(player: player).order(completed_at: :desc).first.ratings.find_by(player: player)
  end
end
