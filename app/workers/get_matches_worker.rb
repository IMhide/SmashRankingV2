class GetMatchesWorker
  include Sidekiq::Worker

  def perform(tournament_id, remote_event_id)
    @tournament = Tournament.find(tournament_id)
    ActiveRecord::Base.transaction do
      actions(remote_event_id: remote_event_id)
    end
    @tournament.update(match_sync: :success)
  rescue Exception => e
    @tournament.update(match_sync: :failure)
    raise e
  end

  private

  def actions(remote_event_id:)
    remote_matches = SmashGg::GetEventMatches.new(event_remote_id: remote_event_id).call
    remote_matches.each do |remote_match|
      match_params = extract_result(remote_match)
      next if [match_params[:winner_score], match_params[:looser_score]].include?(nil)
      Match.create!(match_params)
    end
  end

  def extract_result(match)
    winner_slot = match['slots'].find { |s| s['entrant']['id'] == match['winnerId'] }
    looser_slot = match['slots'].find { |s| s['entrant']['id'] != match['winnerId'] }

    {
      winner_id: Player.select(:id).find_by(remote_id: slot_player_remote_id(winner_slot)).id,
      looser_id: Player.select(:id).find_by(remote_id: slot_player_remote_id(looser_slot)).id,
      winner_score: slot_score(winner_slot),
      looser_score: slot_score(looser_slot),
      tournament_id: @tournament.id,
      completed_at: Time.at(match['completedAt'])
    }
  end

  def slot_player_remote_id(slot)
    slot['entrant']['participants'].first['player']['id']
  end

  def slot_score(slot)
    slot['standing']['stats']['score']['value']
  end
end
