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

  post '/tweets' do
    user = User.find(session[:user_id])
    Tweet.create(content: params[:content], user_id: user.id)
    redirect '/tweets'
  end

  get 'tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:slug' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'/tweets/show'
    else
      redirect '/login'
    end    
  end

end
