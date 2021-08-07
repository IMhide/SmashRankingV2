class ComputeRating < BaseService
  def initialize(ranking:)
    @ranking = ranking
  end

  def call
    flush_result
    Match.joins(:tournament).where(tournament: {ranking_id: @ranking.id}).order(:completed_at).each { |match| rate_match(match) }
  end

  private

  def flush_result
    Rating.where(ranking_id: @ranking.id, base: false).delete_all
  end

  def rate_match(match)
    winner_rating = player_rating(match.winner_id, match.id)
    looser_rating = player_rating(match.looser_id, match.id)
    coef = get_coef(match.tournament)

    r_winner = set_trueskill_ratings(winner_rating, coef)
    r_looser = set_trueskill_ratings(looser_rating, coef)

    graph = Saulabs::TrueSkill::ScoreBasedBayesianRating.new(r_winner => match.winner_score.to_i,
      r_looser => match.looser_score.to_i)
    graph.update_skills

    Rating.create!(ranking_id: @ranking.id, match_id: match.id, player_id: match.winner_id, mean: r_winner.first.mean,
      deviation: r_winner.first.deviation)
    Rating.create!(ranking_id: @ranking.id, match_id: match.id, player_id: match.looser_id, mean: r_looser.first.mean,
      deviation: r_looser.first.deviation)
  end

  def get_coef(tournament)
    @ranking.tier_list.public_send("#{tournament.tier}_coef".downcase)
  end

  def player_rating(player_id, match_id)
    rating = Rating.where(player_id: player_id, ranking_id: @ranking.id).order(created_at: :desc).first

    if rating.nil? && !@ranking.previous_season_id.nil?
      previous_rating = Rating.where(player_id: player_id, ranking_id: @ranking.previous_season_id).order(created_at: :desc).first
      if !previous_rating.nil?
        params = previous_rating.attributes
        params['id'] = nil
        params['ranking_id'] = @ranking.id
        params['deviation'] = BigDecimal(25 / 3)
        rating = Rating.create!(params.merge({base: true}))
      end
    end
    rating || Rating.create!(player_id: player_id, match_id: match_id, ranking_id: @ranking.id, mean: BigDecimal('25'), deviation: BigDecimal(25 / 3), base: true)
  end

  def set_trueskill_ratings(rating, coef)
    [Saulabs::TrueSkill::Rating.new(rating.mean, rating.deviation, coef)]
  end
end
