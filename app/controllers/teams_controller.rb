class TeamsController < ApplicationController
  def list
  	@teams= Team.find(:all)
   # @matches= Match.find(:all)
  end 
  def new
  	@team = Team.new
  	10.times {@team.players.build}
  end
  def create
  	@team = Team.new(params[:team])
    save = @team.save
  	unless @team.save
      flash[:error] = "Invalid details. Either the team or player name is empty"
      redirect_to :action => 'new'	
  	else
      flash[:success] = "Successfully created a team with players"
      @teams= Team.find(:all)
      render 'teams/list'
  	end
  end
end