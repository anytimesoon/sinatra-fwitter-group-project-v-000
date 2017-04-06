require './config/environment'

class TweetController < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/users/:slug' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
    end    
  end

end
