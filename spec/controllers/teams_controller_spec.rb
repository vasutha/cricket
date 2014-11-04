require 'rails_helper'
# Rails.logger.info 'gdfgdfg'
describe TeamsController do
	render_views	
	self.use_transactional_fixtures = false

	it "should create a new team with players" do
		post :create, :team => {:team_name => 't2' , :players_attributes => {"0"=>{"player_name"=>"pp1"}, "1"=>{"player_name"=>"pp2"}, "2"=>{"player_name"=>"pp3"}, "3"=>{"player_name"=>"pp4"}, "4"=>{"player_name"=>"pp5"}, "5"=>{"player_name"=>"pp6"}, "6"=>{"player_name"=>"pp7"}, "7"=>{"player_name"=>"pp8"}, "8"=>{"player_name"=>"pp9"}, "9"=>{"player_name"=>"pp10"}}} 
		expect(response).to render_template('/list')
	end

	it "should go to home page" do
		get :new
		response.should be_success
		response.should render_template('/new')
		response.body.should =~ /Team Details/
	end

	it "should list all team details" do
		get :list
		response.should be_success
		response.should render_template('/list')
		response.body.should =~ /Match Details/
	end

end