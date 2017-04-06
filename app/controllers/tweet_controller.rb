require './config/environment'

class TweetController < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

end
