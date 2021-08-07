FactoryBot.define do
  factory :tournament do
    tournament_remote_id { 'MyString' }
    event_remote_id { 'MyString' }
    remote_participant_count { 1 }
    name { 'MyString' }
    slug { 'MyString' }
    dated_at { '2021-07-27 16:34:48' }
  end
end
