class Batting < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  belongs_to :player
  attr_accessible :dismissal_type, :dismissed_by, :match_id, :order, :player_id, :team_id
  #validates :player_id , presence: true
  #validates :match_id , presence: true
  #validates :team_id , presence: true
end