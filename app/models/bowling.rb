class Bowling < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  belongs_to :player
  attr_accessible :match_id, :order, :player_id, :team_id
  validates :player_id , presence: true
  validates :match_id , presence: true
  validates :team_id , presence: true
  validates :order , presence: true
end
