require 'rails_helper'

describe Ball do

	before(:each) do
		@ball = Ball.new
	end

	after(:each) do
		@ball = nil
	end

	it "is a valid ball" do
		@ball.update_attributes(match_id: '1', over_id: '1', player_id: '6', four: false, six: false , nb: false, wides: false, wicket: false, runs: '2', ballcount: '1')
		@ball.valid?
		expect(@ball).to be_valid
	end

	it "is invalid when batsman is nil" do
		@ball.update_attributes(player_id: nil)
		@ball.valid?
		expect(@ball.errors[:player_id]).to include("can't be blank")
	end

	it "is invalid when match is nil" do
		@ball.update_attributes(match_id: nil)
		@ball.valid?
		expect(@ball.errors[:match_id]).to include("can't be blank")
	end

	it "is invalid when over is nil" do 
		@ball.update_attributes(over_id: nil)
		@ball.valid?
		expect(@ball.errors[:over_id]).to include("can't be blank")
	end

	it "is invalid when runs is nil" do
		@ball.update_attributes(runs: nil)
		@ball.valid?
		expect(@ball.errors[:runs]).to include("can't be blank")
	end
	
	it "is invalid when ballcount is nil" do
		@ball.update_attributes(ballcount: nil)
		@ball.valid?
		expect(@ball.errors[:ballcount]).to include("can't be blank")
	end

end