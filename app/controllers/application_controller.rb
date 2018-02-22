require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fW1tT3r"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @users = User.all
    @tweets = Tweet.all
    erb :index
  end

  get '/signup' do
    erb :"users/create_user"
  end

  get '/login' do

  end

  post '/signup' do

    redirect to "/tweets"
  end

end
