class GenerateStandings < BaseService
  def initialize(ranking:)
    @ranking = ranking
  end

  def call
    result = sql_call
    result = set_score(result)
    @ranking.update(standing: add_position(result))
  end

  private

  def sql_call
    sql = "SELECT ratings.player_id, ratings.ranking_id, MAX(ratings.created_at) as created_at, COUNT(ratings.created_at) as match_count, COUNT(DISTINCT(matches.tournament_id)) as tournament_count \
    FROM ratings \
    INNER JOIN matches ON ratings.match_id = matches.id \
    WHERE ratings.base = false \
    GROUP BY player_id, ranking_id"

    sqlq = "SELECT ratings.mean, ratings.deviation, players.id, players.name, players.team, match_count, tournament_count\
    FROM (#{sql}) AS lastest_ratings\
    INNER JOIN ratings ON lastest_ratings.player_id = ratings.player_id AND lastest_ratings.created_at = ratings.created_at\
    INNER JOIN players ON ratings.player_id = players.id WHERE ratings.ranking_id = #{@ranking.id}"
    ActiveRecord::Base.connection.execute(sqlq).to_a
  end

  def set_score(result)
    result.map do |hash|
      hash.merge({score: compute_score(hash['mean'], hash['deviation'])})
    end.sort { |a, b| b[:score] <=> a[:score] }
  end

  def compute_score(mean, deviation)
    (((BigDecimal(mean) * BigDecimal('1')) - (BigDecimal('3') * BigDecimal(deviation))) * BigDecimal('100')).to_i
  end

  def add_position(result)
    result.each_with_index.map do |h, i|
      h[:name] = [h['team'], h.delete('name')].compact.join(' | ') unless h['team'].blank?
      h.delete('team')
      h.merge({position: i + 1}).with_indifferent_access
    end
  end
end
