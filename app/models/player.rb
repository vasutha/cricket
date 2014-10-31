class Player < ActiveRecord::Base
  attr_accessible :player_name , :team_id
  belongs_to :team
  has_many :overs , dependent: :destroy
  has_many :balls , dependent: :destroy
  has_many :battings , dependent: :destroy
  has_many :bowlings , dependent: :destroy
  validates :player_name , presence: true
  #validates :team_id , presence: true
end