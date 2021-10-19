class GenerateStandings < BaseService
  def initialize(ranking:)
    @ranking = ranking
  end

  def call
    @result = sql_call

    set_score
    @ranking.update(
      tmp_standing: add_position(@result),
      standing: add_position(@result.select { |rank| rank[:placement] })
    )
  end

  private

  def sql_call
    sql = "SELECT ratings.player_id, ratings.ranking_id, MAX(ratings.created_at) as created_at, COUNT(ratings.created_at) as match_count, COUNT(DISTINCT(matches.tournament_id)) as tournament_count \
    FROM ratings \
    INNER JOIN matches ON ratings.match_id = matches.id \
    WHERE ratings.base = false AND ranking_id = #{@ranking.id}\
    GROUP BY player_id, ranking_id"

    sqlq = "SELECT ratings.mean, ratings.deviation, players.id, players.name, players.team, players.foreigner, match_count, tournament_count\
    FROM (#{sql}) AS lastest_ratings\
    INNER JOIN ratings ON lastest_ratings.player_id = ratings.player_id AND lastest_ratings.created_at = ratings.created_at\
    INNER JOIN players ON ratings.player_id = players.id WHERE ratings.ranking_id = #{@ranking.id}"
    ActiveRecord::Base.connection.execute(sqlq).to_a
  end

  def set_score
    @result = @result.map do |hash|
      hash.merge({
        score: compute_score(hash['mean'], hash['deviation']),
        placement: compute_eligibility(tournament_count: hash['tournament_count'], match_count: hash['match_count'], is_foreigner: hash['foreigner'])
      })
    end.sort { |a, b| b[:score] <=> a[:score] }
  end

  def compute_score(mean, deviation)
    (((BigDecimal(mean) * BigDecimal('1')) - (BigDecimal('3') * BigDecimal(deviation))) * BigDecimal('100')).to_i
  end

  def compute_eligibility(tournament_count:, match_count:, is_foreigner:)
    (is_foreigner && tournament_count.to_i >= 6) || (!is_foreigner && tournament_count.to_i >= 3 && match_count.to_i >= 12)
  end

  def add_position(result, temporary: false)
    result.each_with_index.map do |h, i|
      h[:name] = [h['team'], h.delete('name')].compact.join(' | ') unless h['team'].blank?
      h.delete('team')
      h.merge({position: i + 1}).with_indifferent_access
    end
  end
end
