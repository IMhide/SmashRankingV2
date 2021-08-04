class GetMatchesWorker
  include Sidekiq::Worker

  def perform(tournament_id, remote_event_id)
    ActiveRecord::Base.transaction do
      tournament = Tournament.find(tournament_id)
      actions(tournament: tournament, remote_event_id: remote_event_id)
      tournament.update(match_sync: :success)
    end
  rescue Exception => e
    tournament.update(match_sync: :failure)
    raise e
  end

  private

  def actions(tournament:, remote_event_id:)
    remote_matches = SmashGg::GetEventMatches.new(event_remote_id: remote_event_id).call
    remote_matches.each do |remote_match|
      extract_result(remote_match)
    end
  end

  def extract_result(match)
    {
      winner: match['slots'].find { |s| s['entrant']['id'] == match['winnerId'] },
      looser: match['slots'].find { |s| s['entrant']['id'] == match['winnerId'] }
    }
  end
end
