class Match < ActiveRecord::Base
  has_many :battings , dependent: :destroy
  has_many :bowlings , dependent: :destroy
  has_many :overs
  has_many :balls
  has_many :games , dependent: :destroy
  has_many :tournaments , dependent: :destroy
  belongs_to :team
  attr_accessible :bat_first, :date, :mom, :place, :team1, :team2, :team_won, :toss_won
  validates :bat_first , presence: true
  #validates :date , presence: true
  #validates :mom , presence: true
  #validates :place , presence: true
  #validates :team_won , presence: true
  validates :toss_won , presence: true
  before_create :ensure_team_has_a_value
  after_save :retrieve_match_id
  accepts_nested_attributes_for  :overs , :games
  	protected
  		def ensure_team_has_a_value
  			 if (team1.nil? || team2.nil? || (team1.nil? && team2.nil?))
  				self.errors.add(:team1, "Team cannot be empty") 
          return false
        elsif team1 == team2
  				self.errors.add(:team1, "Teams need to be different") 
          return false
  			end
  		end
    protected
        def retrieve_match_id
            match_id = self.id
        end

end
