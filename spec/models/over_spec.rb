require 'rails_helper'

describe Over do 

	before(:each) do
		@over = Over.new
	end

	after(:each) do
		@over = nil
	end


	it "is a valid over" do 
		@over.update_attributes(team_id: '1', player_id: '2', match_id: '1' , count: '1')
		@over.valid?
		expect(@over).to be_valid
	end

	it "is invalid when team is nil" do
		@over.update_attributes(team_id: nil)
		@over.valid?
		expect(@over.errors[:team_id]).to include("can't be blank")
	end

	it "is invalid when match is nil" do
		@over.update_attributes(match_id: nil)
		@over.valid?
		expect(@over.errors[:match_id]).to include("can't be blank")
	end

	it "is invalid when player is nil" do
		@over.update_attributes(player_id: nil)
		@over.valid?
		expect(@over.errors[:player_id]).to include("can't be blank")
	end

	it "is invalid when over count is nil" do
		@over.update_attributes(count: nil)
		@over.valid?
		expect(@over.errors[:count]).to include("can't be blank")
	end

end