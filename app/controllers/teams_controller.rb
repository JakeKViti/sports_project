class TeamsController < ApplicationController
    get "/teams" do
      if logged_in?
        @teams = Team.all
        erb :'teams/homepage'
      else
        redirect to '/login'
      end
    end
 
    get "/teams/new" do
      if logged_in?
        erb :'teams/createteams'
      else
        redirect to '/login'
      end
    end

    post "/teams" do
      if logged_in?
        if params[:sport] == "" || params[:num_of_players] == "" ||  params[:team_name] == "" || params[:location] == "" 
          redirect to "/teams/new"
        else
          @teams = Team.create(sport: params[:sport], num_of_players: params[:num_of_players], team_name: params[:team_name], location: params[:location], coach: current_user)
          if @teams.save
            redirect to "/teams/#{@teams.id}"
          else
            redirect to "/teams/new"
          end
        end
      else
        redirect to '/login'
      end
    end

    get '/teams/:id' do
      if logged_in?
        @team = Team.find(params[:id]) 
        if  @team.coach_id == current_user.id
        erb :'teams/show'
        else
          redirect to '/failed'
        end
      else
        redirect to '/login'
      end
    end

    get "/allteams" do
      if logged_in?
        @user = Coach.all
        @teams = Team.all
        erb :'teams/allteams'
      else
        redirect to '/login'
      end
    end

    get "/coachteams" do
      if logged_in?
        @teams = Team.all
        erb :'teams/coachteams'
      else
        redirect to '/login'
      end
    end

    get "/edit/:id" do
      if logged_in?
        @team = Team.find(params[:id]) 
        if  @team.coach_id == current_user.id
        erb :'teams/edit'
      else
        redirect to '/failed'
      end
    else
      redirect to '/login'
    end
  end
    

    patch '/edit/:id' do
      if logged_in?
        if params[:sport] == "" || params[:num_of_players] == "" ||  params[:team_name] == "" || params[:location] == "" 
          redirect to "/edit/#{params[:id]}"
        else
          @teams = Team.find(params[:id])
          if @teams && @teams.coach_id == current_user.id
            if @teams.update(sport: params[:sport], num_of_players: params[:num_of_players], team_name: params[:team_name], location: params[:location])
              redirect to "/teams/#{@teams.id}"
            else
              redirect to "/edit/#{params[:id]}"
            end
          else
            redirect to '/coachteams'
          end
        end
      else
        redirect to '/login'
      end
    end

    get '/delete/:id' do
      if logged_in?
        @teams = Team.find(params[:id])
        if @teams && @teams.coach_id == current_user.id
          @teams.delete
        else
          redirect to '/failed'
        end
        redirect to '/coachteams'
      else
        redirect to '/login'
      end
    end

    get '/failed' do
      erb :'teams/failed' 
    end

end