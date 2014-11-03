class OversController < ApplicationController
  def overs
  	@match_id = params[:match_id]
    #@oversall = params[:overs]
    @overs = Over.find(:all)
  	@match = Match.find(@match_id)
  	if(@match.team1 == @match.bat_first)
  		@bowl_teamid = @match.team2
  	elsif (@match.team2 == @match.bat_first)
  		@bowl_teamid = @match.team1
  	end 
  	@bowl_team = Team.find(@bowl_teamid)

    #populate players under batting and bowling
  	@players_bowling = Player.where(team_id: @bowl_teamid ).select('id,player_name')
  	@players_batting = Player.where(team_id: @match.bat_first ).select('id,player_name')

    #retrieve details from batting table and remove them from current players list
    @batting_players = Batting.where("team_id = ? AND match_id = ?", @match.bat_first , @match_id).select('player_id')
    @team_detail = Team.find(@match.bat_first)
    if(@batting_players !=nil && @batting_players.size > 0)
      @players_batting = @team_detail.players.all(:include => :battings).reject! {|player| player.battings.present?} 
    end
    if(@players_batting.size <= 0 )
       @teams = Team.find(:all)
       render :template => 'teams/list'  
    end

    #auto-populate over values after each over
    @over_last = Over.find(:last)
    if(@over_last != nil)
      @over_count =  @over_last.count.to_i + 1
    else
      @over_count = 1
    end

    #object creation for overs and ball
  	@over = Over.new
  	@over.balls.build
  end

  def create
  	@over = Over.new(params[:over])
    #check for over count with respect to the previous overs
    @over_last = Over.find(:last)
    if(@over_last!=nil)
      if( @over_last.count.to_i != @over.count.to_i - 1)
        flash[:error] = "Invalid over count. The over count should be #{@over_last.count.to_i + 1}"
        redirect_to :action => 'overs' , :match_id => @over.match_id
        return
      end
    end
    @ball = @over.balls[0]

    #validations check for auto check values(4's and 6's and ball count)
    if(@ball.four == true && @ball.runs.to_i != 4)
      p @ball.runs
      flash[:error] = "Invalid run count"
      redirect_to :action => 'overs' , :match_id => @over.match_id
      return
    elsif (@ball.six == true && @ball.runs.to_i != 6)
      flash[:error] = "Invalid run count"
      redirect_to :action => 'overs' , :match_id => @over.match_id
      return
    end
    if(@ball.ballcount.to_i != 1)
      flash[:error] = "Invalid ball count."
      redirect_to :action => 'overs' , :match_id => @over.match_id
      return
    end

    #check for wickets and add to the batting team
    if(@ball.wicket == true)
        #add details to the batting team
        batting = Batting.new
        batting.player_id =  @ball.player_id
        batting.match_id = @ball.match_id
        player_team_id = Player.where(id: @ball.player_id).select('team_id')
        batting.team_id =  player_team_id[0].team_id
        player = Player.find(@over.player_id)
        batting.dismissed_by = player.player_name
        if(batting.save!)
          flash[:success] = "Wicket lost" 
        end
    end

    #check for the number of overs
    if(@over.count.to_i >= 9 || @ball.ballcount.to_i >=7 )
      flash[:error] = "Invalid over/ball count"
      redirect_to :action => 'overs' , :match_id => @over.match_id
      return
    end
    
    #save details of over in db
  	unless @over.save
      flash[:error] = "Invalid over/ball count or player details are mentioned"
      redirect_to :action => 'overs' , :match_id => @over.match_id
    else
  		flash[:notice] = "Successfully started the overs"
  		@match_id = @over.match_id
  		#@overid = @over.id
      #@ball = Ball.find(:last)
      @overs = Over.find(:all)
  		render :action => 'show' 
  	end
  end

  def show
    @overs = Over.find(:all)
  end
end