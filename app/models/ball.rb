class Ball < ActiveRecord::Base

  belongs_to :player
  belongs_to :over
  belongs_to :match
  #validates :over_id , presence: true
  #validates :match_id, presence: true
  validates :player_id , presence: true
  validates :runs , presence: true
  attr_accessible :four, :nb, :over_id, :player_id, :runs, :six, :wicket, :wides ,:ballcount ,:match_id
  alias_attribute :batsman_id, :player_id
end
