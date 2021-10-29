class SyncTournamentEvent < BaseService
  def initialize(tournament:, remote_event_id:)
    @tournament = tournament
    @remote_event_id = remote_event_id
  end

  def call
    @tournament.update(event_remote_id: @remote_event_id)
    sync_standings
    set_tier
    sync_matches
  end

  private

  def sync_standings
    SmashGg::Finders::GetEventStandings.new(event_remote_id: @remote_event_id).call.each do |standing|
      Participation.create!(seed: standing[:seed], placement: standing[:placement], player: sync_player(standing),
        tournament: @tournament, verified: standing[:verified], dq: !!standing[:dq])
    end
  end

  def set_tier
    tier = @tournament.ranking.tier_list.find_tier(@tournament.participations.where(dq: false).count)
    @tournament.update(tier: tier)
  end

  def sync_matches
    @tournament.update(match_sync: :running)
    GetMatchesWorker.perform_async(@tournament.id, @remote_event_id)
  end

  def sync_player(standing)
    db_player = Player.find_by(remote_id: standing[:player_id]) ||
      Player.create!(name: standing[:player_name],
        team: standing[:player_team],
        remote_id: standing[:player_id])
    db_player.update(team: standing[:player_team]) if db_player.team != standing[:player_team]
    db_player
  end
end
