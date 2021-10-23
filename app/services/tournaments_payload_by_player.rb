class TournamentsPayloadByPlayer < BaseService
  def initialize(player:, ranking:)
    @player = player
    @ranking = ranking
  end

  def call
    @player.tournaments.includes(:participations).where(ranking: @ranking).order(dated_at: :desc).map do |tournament|
      player_participation = tournament.participations.where(player: @player).first
      current_rating = tournament.get_last_rating_for(player: @player)
      previous_rating = previous_rating_for(tournament: tournament)

      payload_for(tournament: tournament, participation: player_participation,
        score_diff: current_rating.score - previous_rating.score)
    end
  end

  private

  def payload_for(tournament:, participation:, score_diff:)
    {
      name: tournament.name,
      tier: tournament.tier,
      seed: participation.seed,
      placement: participation.placement,

      match_count: tournament.match_count_for(player: @player),
      point_diff: score_diff
    }
  end

  def previous_rating_for(tournament:)
    previous_tournament = @player.previous_tournament_for(ranking: @ranking, tournament: tournament)

    if previous_tournament.nil?
      Rating.find_by(ranking: @ranking, base: true) ||
        Rating.new(mean: BigDecimal('25'), deviation: BigDecimal(25 / 3))
    else
      previous_tournament.get_last_rating_for(player: @player)
    end
  end
end
