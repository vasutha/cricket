require 'rails_helper'

describe Team do 

	before(:each) do
		@team = Team.new
	end

	after(:each) do
		@team = nil
	end

	it "is invalid without team name" do
		@team.update_attributes(team_name: nil)
		@team.valid?
		expect(@team.errors[:team_name]).to include("can't be blank")
	end

	it "is valid with team name" do
		@team.update_attributes(team_name: 'test_team')
		expect(@team).to be_valid
	end

end