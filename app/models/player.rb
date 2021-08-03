class Player < ApplicationRecord
  validates :name, presence: true
  validates :remote_id, presence: true
end
