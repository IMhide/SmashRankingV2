class ComputeRating < BaseService
  def initialize(ranking:)
    @ranking = ranking
  end

  def call
    flush_result
    Match.where(ranking_id: @ranking_id).order(:completed_at).each { |_match| rate_match(matcha) }
  end

  private

  def flush_result
    Rating.where(ranking_id: @ranking.id, base: false).delete_all
  end

  def rate_match(match)
    winner_rating = player_rating(match.winner_id, match.id)
    looser_rating = player_rating(match.winner_id, match.id)
    coef = get_coef(match.tournament)

    r_winner = set_trueskill_ratings(winner_rating, coef)
    r_looser = set_trueskill_ratings(looser_rating, coef)
    graph = Saulabs::TrueSkill::ScoreBasedBayesianRating.new(r_winner => match.winner_score.to_i,
                                                             r_looser => match.looser_score.to_i)
    graph.update_skills
    Rating.create!(ranking_id: @ranking.id, match_id: match.id, player_id: match_winner_id, mean: r_winner.first.mean,
                   deviation: r_winner.first.deviation)
    Rating.create!(ranking_id: @ranking.id, match_id: match.id, player_id: match_looser_id, mean: r_looser.first.mean,
                   deviation: r_looser.first.deviation)
  end

  def get_coef(tournament)
    @ranking.tier_list.public_send("#{tournament.tier}_coef".downcase)
  end

  def player_rating(player_id, match_id)
    Rating.where(player_id: player_id, ranking_id: @ranking.id).order(created_at: :desc).first ||
      Rating.create!(player_id: player_id, match_id: match_id, ranking_id: @ranking.id, mean: BigDecimal('25'),
                     deviation: BigDecimal(25 / 3), base: true)
  end

  def set_trueskill_ratings(rating, coef)
    [Saulabs::TrueSkill::Rating.new(rating.mean, rating.deviation, coef)]
  end
end
