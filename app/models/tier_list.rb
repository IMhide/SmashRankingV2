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

  def format; end

  def find_tier(count)
    return :SS if count >= ss_min
    return :S if count >= s_min
    return :A if count >= a_min
    return :B if count >= b_min
    return :C if count >= c_min

    :none
  end
end
