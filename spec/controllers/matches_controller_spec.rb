require 'rails_helper'

describe MatchesController do
	render_views	
	self.use_transactional_fixtures = false

	it "should list all matches" do
		get :list
		response.should be_success
		response.should render_template('/list')
		response.body.should =~ /Batting First/
	end

	#it "should go to match home page" do
		#get :match
		#response.should be_success
		#response.should render_template('/match')
		#response.body.should =~ /Place/
	#end

	it "should create a match" do
		post :create , :match => {"team1"=>"2", "team2"=>"16", "toss_won"=>"2", "bat_first"=>"16", "date"=>"11/04/2014", "place"=>"chennai"}
		expect(response).to render_template('/list')
	end
end