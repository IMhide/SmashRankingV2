class TierList < ApplicationRecord
  validates :ss_coef, presence: true
  validates :ss_min, presence: true
  validates :s_coef, presence: true
  validates :s_min, presence: true
  validates :a_coef, presence: true
  validates :a_min, presence: true
  validates :b_coef, presence: true
  validates :b_min, presence: true
  validates :c_coef, presence: true
  validates :c_min, presence: true

  belongs_to :ranking, inverse_of: :tier_list
end
