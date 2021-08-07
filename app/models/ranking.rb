class Ranking < ApplicationRecord
  StandingStruct = Struct.new(:position, :name, :score, :match_count)
  extend Enumerize

  validates :name, presence: true

  has_many :tournaments, inverse_of: :ranking
  has_many :ratings, inverse_of: :ranking

  has_one :tier_list, inverse_of: :ranking
  has_one :next_season, class_name: 'Ranking', foreign_key: 'previous_season_id'

  belongs_to :previous_season, class_name: 'Ranking', inverse_of: 'next_season', optional: true

  enumerize :compute_state, in: %i[not_started running success failure], default: :not_started

  def formated_standing
    standing.map do |player|
      StandingStruct.new(player['position'], player['name'], player['score'], player['match_count'])
    end
  end
end
