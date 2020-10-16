class TeamsController < ApplicationController
    get "/index" do
        erb :'teams/index'
    end
end