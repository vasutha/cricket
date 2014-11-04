require 'rails_helper'
describe OversController do

	render_views
	self.use_transactional_fixtures = false

	it "should create overs and balls" do
		post :create ,:over => {:player_id=>"12", :team_id=>"2", :match_id=>"1", :count=>"5", :balls_attributes=>{"0"=>{:match_id=>"1", :ballcount=>"1", :four=>"0", :six=>"0", :nb=>"0", :wides=>"0", :wicket=>"0", :runs=>"3", :player_id=>"2"}}}
		expect(response).to render_template('/show')
	end

	it "should require bowler" do
		over = Over.create(:player_id => "")	
		over.valid?
		over.errors.should have_key(:player_id)
		#Over.build(:over, :player_id => "").should_not be_valid
	end

	it "ball should require batsman" do
		ball = Ball.create(:player_id => "")
		ball.valid?
		ball.errors.should have_key(:player_id)
	end
	it "checkboxes for 4's" do
		ball = Ball.create(:four => true , :runs => 4)
		expect(ball.runs).to eq(4)
	end

	it "checkboxes for 6's" do
		ball = Ball.create(:six => true, :runs => 6)
		expect(ball.runs).to eq(6)
	end

	it "no ball to be true" do
		ball = Ball.create(:nb =>true, :runs => 1)
		expect(ball.runs).to eq(1)
	end

	it "check for runs" do
		ball = Ball.create(:runs => 6)
		expect(ball.runs).to be <= 6
	end

	it "check for wickets" do
		ball = Ball.create(:wicket => true, :runs => 0)
		expect(ball.runs).to eq(0)
	end

end