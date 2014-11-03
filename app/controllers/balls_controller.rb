class BallsController < ApplicationController
	def ball
		@over = params[:over]
		@over_details = Over.find(@over)
		ball_details = Ball.where(over_id: @over)
		playerid = ball_details[0].player_id
		teamId = Player.where(id: playerid).select('team_id')
		match = Match.find(@over_details.match_id)
		team_id = match.bat_first
		@players_batting = Player.where(team_id: teamId ).select('id,player_name')
		@batting_players = Batting.where("team_id = ? AND match_id = ?", team_id , @over_details.match_id).select('player_id')
		@team_detail = Team.find(team_id)
		@ball = Ball.new
		
		#display players who are still on ground
		if(@batting_players !=nil && @batting_players.size > 0)
      		@players_batting = @team_detail.players.all(:include => :battings).reject! {|player| player.battings.present?} 
      	end
      	if(@players_batting.size <= 0 )
	       @teams = Team.find(:all)
	       render :template => 'teams/list'  
    	end
    	ball_last = Ball.find(:last)
		@overs_last = Over.find(:last)
		@ball_count = ball_last.ballcount.to_i + 1
		@bat_count = Batting.find(:all,:conditions => ["match_id =  ?" ,match.id]).size
		if(@bat_count == 9)
			@teams = Team.find(:all)
			render :template => 'teams/list'	
		end
	end

	def create
		count_ball = 0
		@ball =  Ball.new(params[:ball])
		@ball_last = Ball.find(:last)
		@overs_last = Over.find(:last)

		#validations for ball count
		if(@ball_last.id!=nil)
			if( @ball_last.ballcount.to_i != @ball.ballcount.to_i - 1)
		        flash[:error] = "Invalid ball count. The ball count should be #{@ball_last.ballcount.to_i + 1}"
		        redirect_to :action => 'ball' , :match_id => @ball.over_id
		        return
      		end
		end
		if (@ball_last.id ==nil)
			if(@ball.ballcount.to_i >=7 && @ball.nb == false && @ball.wides == false)
			flash[:error] = "Invalid ball count"
			redirect_to :action => 'ball' , :over => @ball.over_id
			return
			end
		end

		#validations check for auto check values(4's and 6's)
		if(@ball.four == true && @ball.runs.to_i!=4)
			flash[:error] = "Invalid run count"
			redirect_to :action => 'ball' , :over => @ball.over_id
			return
		elsif (@ball.six == true && @ball.runs.to_i !=6)
			flash[:error] = "Invalid run count"
			redirect_to :action => 'ball' , :over => @ball.over_id
			return
		end
			
		#save ball details 
		if @ball.save!
			@over = @ball.over_id
			@match_id = @ball.match_id
			if(@ball.wicket == true)
		        #add details to the batting team
		        batting = Batting.new
		        batting.player_id =  @ball.player_id
		        batting.match_id =   @ball.match_id
		        player_team_id = Player.where(id: @ball.player_id).select('team_id')
        		batting.team_id =  @player_team_id[0].team_id
		        @over_details = Over.find(@over)
		        player = Player.find(@over_details.player_id)
		        batting.dismissed_by = player.player_name
			        if(batting.save!)
			          flash[:success] = "Wicket lost" 
			        end
    		end
    		#check for the count of balls for that particular over
    		ball_all = Ball.where(over_id: @ball.over_id)
    		ball_all.each_with_index do|b,i|
    			if(b.nb == true || b.wides == true)
    				count_ball = count_ball + 1;
    			end
    		end

    		#valid ball count
			if(@ball.ballcount.to_i < count_ball.to_i + 6)
				redirect_to :action => 'ball', :over => @over
			else
				@matches = Match.find(:all)
				@overs = Over.find(:all)
				if (@overs_last.count == 8)
					@teams = Team.find(:all)
					render :template => 'teams/list'	
				else
					render :template => 'matches/list'
				end
			end
		end
	end
end