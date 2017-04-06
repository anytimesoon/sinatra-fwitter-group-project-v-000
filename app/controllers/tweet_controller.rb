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
    params[:content] = nil if params[:content] == ""
    tweet = Tweet.new(content: params[:content], user_id: user.id)
    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      params[:content] = nil if params[:content] == ""
      tweet = Tweet.find(params[:id])
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}/edit"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end
end
