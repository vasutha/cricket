class Game < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  attr_accessible :match_id, :team_id
  validates :match_id , presence: true
  validates :team_id , presence: true
end
