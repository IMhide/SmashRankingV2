class Rating < ApplicationRecord
  validates :mean, presence: true
  validates :deviation, presence: true

  belongs_to :match, inverse_of: :ratings
  belongs_to :ranking, inverse_of: :ratings
  belongs_to :player, inverse_of: :ratings

  def score
    (((BigDecimal(mean) * BigDecimal('1')) - (BigDecimal('3') * BigDecimal(deviation))) * BigDecimal('100')).to_i
  end
end
