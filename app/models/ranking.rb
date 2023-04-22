class Ranking < ApplicationRecord
  StandingStruct = Struct.new(:position, :name, :score, :placement, :foreigner, :tmp)
  extend Enumerize

  validates :name, presence: true

  has_many :tournaments, inverse_of: :ranking, dependent: :destroy
  has_many :ratings, inverse_of: :ranking

  has_one :tier_list, inverse_of: :ranking, dependent: :destroy
  has_one :next_season, class_name: 'Ranking', foreign_key: 'previous_season_id'

  belongs_to :previous_season, class_name: 'Ranking', inverse_of: 'next_season', optional: true

  enumerize :compute_state, in: %i[not_started running success failure], default: :not_started

  def placement_for(player_id:, tmp: false)
    context_standing = tmp ? tmp_standing : standing
    standing_factory(context_standing.find { |s| s['id'] == player_id }, tmp:)
  end

  def participant_count(tmp: false)
    if tmp
      tmp_standing.size
    else
      standing.size
    end
  end

  def formated_standing
    (standing || []).map do |position|
      standing_factory(position)
    end
  end

  def formated_tmp_standing
    (tmp_standing || []).map do |position|
      standing_factory(position, tmp: true)
    end
  end

  def standing_factory(position, tmp: false)
    return if position.nil?
    StandingStruct.new(
      position['position'],
      position['name'],
      position['score'],
      position['placement'],
      position['foreigner'],
      tmp
    )
  end

  def sync_status_tag_class
    {
      failure: 'no',
      success: 'yes'
    }.with_indifferent_access[compute_state]
  end
end
