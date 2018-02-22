require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fW1tT3r"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  helpers do
    def logged_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) ? session[:user_id]
    end

    def logout
      session.clear
    end
  end

  get '/' do
    @users = User.all
    @tweets = Tweet.all
    erb :index
  end

  get '/signup' do
    # binding.pry
    if logged_in?
      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get '/login' do

  end

  post '/signup' do
    # refactor with authenticate
    if User.find_by(username: params[:username]) || User.find_by(email: params[:email])
      flash[:message] = "This username and/or email already exists. Please try again."
      redirect to "/signup"
    elsif params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      flash[:message] = "You must have a username, email, and password in order to sign up. Please try again."
      redirect to "/signup"
    end

    redirect to "/tweets"
  end

end
