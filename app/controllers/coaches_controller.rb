class CoachesController < ApplicationController
  get "/signup" do
    erb :'coaches/signup'
  end
    
  post "/signup" do
    if params[:username] == "" || params[:password] == "" 
      redirect to "/failure"
    else
          
    user = Coaches.create(:username => params[:username], :email => params[:email], :password => params[:password])
    redirect to "/login"
    end
  end
    
    get '/account' do
      @user = Coaches.find(session[:user_id])
      erb :'coaches/account'
    end
    
    
    get "/login" do
      erb :'coaches/login'
    end
    
    post "/login" do
      @user = Coaches.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/account"
      else
        redirect to "/failure"
      end
    end
    
    get "/failure" do
      erb :'coaches/failure'
    end
    
    get "/logout" do
      session.clear
      redirect "/"
    end
end