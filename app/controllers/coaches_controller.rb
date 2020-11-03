class CoachesController < ApplicationController
  get "/signup" do
    erb :'coaches/signup'
  end
    
  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == "" 
      redirect to "/signfailure"
    else    
      user = Coach.create(:username => params[:username], :email => params[:email], :password => params[:password])
      redirect to "/login"
    end
  end
      
    get "/login" do
      erb :'coaches/login'
    end
    
    post "/login" do
      @user = Coach.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/teams"
      else
        redirect to "/logfailure"
      end
    end
    
    get "/logfailure" do
      erb :'coaches/logfailure'
    end

    get "/signfailure" do
      erb :'coaches/signfailure'
    end
    
    get "/logout" do
      session.clear
      redirect "/"
    end
end
