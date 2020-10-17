class TeamsController < ApplicationController
    get "/index" do
        erb :'teams/index'
    end

    get "/createteams" do
        erb :'teams/createteams'
      end

    post "/createteams" do
        if params[:sport] == "" || params[:num_of_players] == "" 
          redirect to "/error"
        else
              
        user = Teams.create(:sport => params[:sport], :num_of_players => params[:num_of_players], :coach_id => params[:coach_id])
        redirect to "/success"
        end
    end

    get "/error" do
        erb :'teams/error'
      end

    get "/success" do
        erb :'teams/success'
    end

end