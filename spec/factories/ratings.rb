FactoryBot.define do
  factory :rating do
    matches { nil }
    rankings { nil }
    players { nil }
    base { false }
    mean { "9.99" }
    deviation { "9.99" }
  end
end
