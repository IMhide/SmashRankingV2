namespace :previous_seasons do
  task season_one: :environment do
    events_remote_id = %w[326007 343930 352841 343986
      351901 339843 340839 344524
      337138 334134 343045 317523
      338475 319102 316436 337062
      322093 321679 297959 321682
      310012 310033 317986 312833
      309498 297021 275278 305035
      287555 273405 301521]
    create_season(events_remote_id, 'Saison 1')
  end

  def create_season(event_ids, season_name)
    ActiveRecord::Base.transaction do
      ranking = Ranking.create!(name: season_name)
      TierList.create(ranking: ranking,
        ss_min: 9999,
        ss_coef: 1.5,
        s_min: 256,
        s_coef: 1.5,
        a_min: 128,
        a_coef: 1.2,
        b_min: 96,
        b_coef: 1,
        c_min: 64,
        c_coef: 0.8)

      event_ids.each do |event_id|
        remote_tournament = SmashGg::GetTournamentByEventId.call(event_id: event_id)
        tournament = Tournament.create!(name: remote_tournament.name,
          slug: remote_tournament.slug.split('/').last,
          tournament_remote_id: remote_tournament.id,
          dated_at: Time.at(remote_tournament.dated_at).to_datetime,
          ranking_id: ranking.id)
        SyncTournamentEvent.new(tournament: tournament, remote_event_id: event_id).call
      end
    end
  end
end
