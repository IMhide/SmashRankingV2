FactoryBot.define do
  factory :match do
    winner { nil }
    looser { nil }
    participation { nil }
    event { nil }
    winner_score { 1 }
    looser_score { 1 }
    completed_at { "2021-08-04 12:51:32" }
  end
end
