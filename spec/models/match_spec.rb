require 'rails_helper'

describe Match do 

	before(:each) do
		@match = Match.new
	end

	after(:each) do
		@match = nil
	end

	it "is valid match" do
		@match.update_attributes(team1: '1', team2: '2', bat_first: '1', date: '4/11/2014' , place: 'chennai', toss_won: '1')
		@match.valid?
		expect(@match).to be_valid
	end

	it "is invalid match when batting first is nil" do
		@match.update_attributes(bat_first: nil)
		@match.valid?
		expect(@match.errors[:bat_first]).to include("can't be blank")
	end

	it "is invalid match when toss is nil" do
		@match.update_attributes(toss_won: nil)
		@match.valid? 
		expect(@match.errors[:toss_won]).to include("can't be blank")
	end

	it "is invalid match when date is nil" do
		@match.update_attributes(date: nil)
		@match.valid?
		expect(@match.errors[:date]).to include("can't be blank")
	end

	it "is invalid match when place is nil" do
		@match.update_attributes(place: nil)
		@match.valid?
		expect(@match.errors[:place]).to include("can't be blank")
	end

	it "is invalid match when team is nil" do
		@match.update_attributes(team1:nil , team2:nil)
		@match.valid?
		expect(@match.errors[:team1]).to include("can't be blank")
	end

	it{
		@match.update_attributes(team1: 1 , team2: 1) 
		p expect{raise @match.run_callbacks(:create) { false }}.to raise_exception
	}
end