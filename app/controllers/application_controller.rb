require "./config/environment"
require "./app/models/coaches"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "The_Scottsdale_Community_College_Fighting_Artichokes"
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!@current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
