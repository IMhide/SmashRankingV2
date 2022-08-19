FactoryBot.define do
  factory :tier_list do
    ss_min { 9999 }
    ss_coef { 3 }
    s_min { 256 }
    s_coef { 2 }
    a_min { 128 }
    a_coef { 1.5 }
    b_min { 98 }
    b_coef { 1 }
    c_min { 64 }
    c_coef { 0.5 }
  end
end
