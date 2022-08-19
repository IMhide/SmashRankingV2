FactoryBot.define do
  factory :ranking do
    name { 'MyString' }

    after(:create) do |ranking|
      create(:tier_list, ranking: ranking)
    end
  end
end
