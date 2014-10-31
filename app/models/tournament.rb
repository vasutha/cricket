class Tournament < ActiveRecord::Base
  belongs_to :match
  attr_accessible :match_id
  validates :match_id , presence: true
end
