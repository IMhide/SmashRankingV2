FactoryBot.define do
  factory :tournament do
    ranking {create(:ranking)}
    name { Faker::Esport.event }
    slug { Faker::Internet.domain_word }
    tournament_remote_id { 'TournamentRemoteId' }
    event_remote_id { 'EventRemoteId' }
    remote_participant_count { 1 }
    tier { [:S, :A, :B, :C].sample }
    match_sync { :success }
    dated_at { '2021-07-27 16:34:48' }
  end
end
