class BattingsController < ApplicationController
  def batting
  	@matchid= params[:match_id]
  	@team1 = params[:team1]
  	@bat_first = params[:batteam_id]
  	@team2 = params[:team2]
  	@batting_team = Team.find(@bat_first)
  	if (@bat_first == @team1)
  		@bowl_first = @team2
  	else
  		@bowl_first = @team1
  	end
  	@bowling_team = Team.find(@bowl_first)
  	@batting = Batting.new
  end
  def create
  	@batting = Batting.new
  	@batting.order = params[:order]
	 @batting.player_id = params[:player_id]
	  @batting.team_id = params[:team_id]  	
  	# @batting.match_id = 
  	p "oder..."
  	p @batting.inspect
  	if(@batting.save!)
  		p "in if"
  	else
  		p "in else"
  	end
  end
end
