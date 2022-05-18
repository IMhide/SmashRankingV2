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

  task season_two: :environment do
    events_remote_ids = ['410371', '424771', '419944', '423833', '415554',
      '389112', '407252', '415156', '415940', '400710',
      '397600', '401564', '406216', '390703', '401454',
      '364751', '382287', '392479', '379436', '379183',
      '361698', '361570', '359584', '330146', '385378',
      '370404', '365139', '340070', '377200', '359585',
      '357251', '368911', '337699', '353692', '344190',
      '365283', '334558', '362237', '352866', '359547',
      '343932', '347376', '345256', '356620']
    create_season(events_remote_ids, 'Saison 2', 1)
  end

  task season_three: :environment do
    events_remote_ids = [542983, 593045, 589605, 599893, 601119,
      575384, 593387, 566452, 566454, 593128,
      591817, 590709, 589260, 588704, 588181,
      589713, 588537, 578460, 575566, 586817,
      588177, 536547, 579000, 581740, 578998,
      582125, 581400, 574441, 574423]
    create_season(events_remote_ids, 'Saison 3', 3)
  end

  task season_four: :environment do 
    events_remote_ids = ["585946", "688598", "673669", "668091", "653227",
                         "690532", "674355", "682301", "676380", "682166",
                         "670727", "671495"]
    create_season(events_remote_ids, 'Saison 4', 4)
  end

  def create_season(event_ids, season_name, previous_season = nil)
    ActiveRecord::Base.transaction do
      ranking = Ranking.create!(name: season_name, previous_season_id: previous_season)
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
        remote_tournament = SmashGg::Finders::GetTournamentByEventId.call(event_id: event_id)
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
