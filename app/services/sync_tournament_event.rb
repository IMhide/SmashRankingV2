class SyncTournamentEvent < BaseService
  def initialize(tournament:, remote_event_id:)
    @tournament = tournament
    @remote_event_id = remote_event_id
  end

  def call
    @tournament.update(event_remote_id: @remote_event_id)
    sync_standings
  end

  def sync_standings
    SmashGg::GetEventStandings.new(event_remote_id: @remote_event_id).call.each do |standing|
      Participation.create!(seed: standing[:seed], placement: standing[:placement], player: sync_player(standing),
                            tournament: @tournament, verified: standing[:verified], dq: standing[:dq])
    end
  end

  def sync_player(standing)
    Player.find_by(remote_id: standing[:player_id]) ||
      Player.create!(name: standing[:player_name],
                     team: standing[:player_team], remote_id: standing[:player_id])
  end
end
