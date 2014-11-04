require 'rails_helper'

describe Player do 

	before(:each) do
		@player = Player.new
	end

	after(:each) do
		@player = nil
	end

	it "is invalid without player name" do
		@player.update_attributes(player_name: nil)
		@player.valid?
		expect(@player.errors[:player_name]).to include("can't be blank")
	end

	it "is valid with player name" do
		@player.update_attributes(team_id: '1', player_name: 'test_player')
		expect(@player).to be_valid
	end

	it "is invalid without team" do
		@player.update_attributes(team_id: nil)
		@player.valid?
		expect(@player.errors[:team_id]).to include("can't be blank")
	end


end