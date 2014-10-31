class Team < ActiveRecord::Base
  attr_accessible :team_name, :players_attributes
  has_many :players , dependent: :destroy
  has_many :games , dependent: :destroy
  has_many :battings , dependent: :destroy
  has_many :bowlings , dependent: :destroy
  has_many :overs ,dependent: :destroy
  #validates :team_name , presence: true , uniqueness: true
  accepts_nested_attributes_for :players
end
