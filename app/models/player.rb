class Player < ApplicationRecord
  validates :name, presence: true
  validates :remote_id, presence: true

  has_many :participations, inverse_of: :player

  def display_name
    [team, name].compact.join(' | ')
  end
end
