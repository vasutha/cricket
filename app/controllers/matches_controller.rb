class MatchesController < ApplicationController
  def list
    @matches = Match.find(:all)
  end
  def match
  	@match = Match.new
  	@teams = Team.find(:all)
    @teamsselect = Team.find(params[:teams_checkbox])
  end

  def create
	@match = Match.new(params[:match])
  	if @match.save!
  		flash[:notice] = "Successfully started the match"
  		#@match_id = @match.id
      @matches = Match.find(:all)
      render :action=>'list'
  	else
  		render :action => 'match'
  	end
  end
end