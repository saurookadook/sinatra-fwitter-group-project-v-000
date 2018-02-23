class UsersController < ApplicationController

  use Rack::Flash

  # get '/signup' do
  #
  # end
  #
  # get '/login' do
  #
  # end

  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

end

# <% if @tweet.user_id == session[:user_id] %>
# <% end %>
