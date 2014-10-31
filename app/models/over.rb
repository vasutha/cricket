class Over < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :match , dependent: :destroy
  has_many :balls
  attr_accessible :count, :match_id, :player_id, :team_id ,:ballcount, :balls_attributes
  validates :team_id , presence: true
  validates :player_id , presence: true
  validates :match_id , presence: true
  validates :count , presence:true
  alias_attribute :bowler_id, :player_id
  accepts_nested_attributes_for :balls
end
