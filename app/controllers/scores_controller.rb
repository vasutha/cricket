class ScoresController < ApplicationController
  def scores
  	@matches = Match.find(:all)
  end
  def scoreboard
  	@match_id = params[:match_id]
  	@match = Match.find(@match_id)
    #display batting 1st innings
  	@ball_runs = Ball.select("balls.player_id as player_id, sum(balls.runs) as runs").group("balls.player_id").where("balls.match_id = #{@match_id}")
  	@fours = Ball.group(:player_id).where("six = ? AND match_id = ? ", true, @match_id).count
  	@sixes = Ball.group(:player_id).where("six = ? AND match_id = ? ", true, @match_id).count
  	@balls= Ball.group(:player_id).where(match_id: @match_id).count(:ballcount)
  	@nb = Ball.where("nb= ? AND match_id= ?",true,@match_id).count("nb")
  	@wides = Ball.where("wides= ? AND match_id= ?",true,@match_id).count("wides")
  	@player_ids = Ball.where("player_id").select("player_id")
  	@player_array = []
  	@player_ids.each do |player|
  		@player_array.push(player.player_id)
  	end
  	@players_to_play = Player.where('id not in (?) and team_id = ?',@player_array,@match.bat_first)
    @total_runs = Ball.select("sum(balls.runs) as runs").where("balls.match_id = #{@match_id}").first

  	#fall of wickets calculation
  	@balls_all = Ball.find(:all, :conditions => ['match_id = ?', @match_id])
  	@count = 0
    @wkts_count =0
  	@wickets_array =[]
  	@balls_all.each_with_index do |b,i|
  		unless b.wicket == true
  			@count = @count + b.runs.to_i
  		else
  			@wkts_count = @wkts_count +1
        if(@wkts_count == 9)
          @wkts_count = 10
        end
        @fall_of_wickets = {}
  			@fall_of_wickets["runs"] = @count
  			@fall_of_wickets["player"] = Player.where("id = ?",b.player_id).select("player_name").first.player_name 
  			@over = Over.find(b.over_id)
  			@fall_of_wickets["bowled"] = Player.where("id = ?",@over.player_id).select("player_name").first.player_name
  			@wickets_array << @fall_of_wickets
  		end
  	end

    #bowling records
    @bowl_arr =[]
    if(@match.bat_first == @match.team1)
      @bowl_first = @match.team2
    else
      @bowl_first = @match.team1
    end

    @over_players =Over.where('match_id = ?',@match_id).order(:player_id)
    @over_players.each_with_index do |o,i|
       @runs = 0 
       @wkt = 0
       @o_balls = o.balls
       @o_balls.each_with_index do |b,j|
          @bowl_json = {}
          @runs = @runs + b.runs.to_i
          if(b.wicket == true)
            @wkt = @wkt + 1
          end
       end

         @bowl_json["runs"] = @runs
         @bowl_json["wicket"] = @wkt
         @bowl_json["player"] = Player.where("id = ?",o.player_id).select("player_name").first.player_name 
         @bowl_json["count"] = 1
         #merge with player who has previously bowled
        if(!@bowl_arr.blank?)
          @bowl_arr.each_with_index do |a,index|
            if(a["player"] == @bowl_json["player"])
              @bowl_json["runs"] = @bowl_json["runs"].to_i + a["runs"]
              @bowl_json["wicket"] = @bowl_json["wicket"].to_i + a["wicket"]
              @bowl_json["player"] = a["player"]
              @bowl_json["count"] = a["count"].to_i + 1
              p index
              @bowl_arr.delete_at(index)
             
            end
          end
        end 
       @bowl_arr << @bowl_json
    end
  end
end