class TeamsController < ApplicationController
    get "/teams" do
      if logged_in?
        @teams = Team.all
        erb :'teams/index'
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
        erb :'teams/show'
      else
        redirect to '/login'
      end
    end

    get "/allteams" do
      if logged_in?
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
        @teams = Team.find(params[:id])
        erb :'teams/edit'
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

    get "/error" do
        erb :'teams/error'
    end

end