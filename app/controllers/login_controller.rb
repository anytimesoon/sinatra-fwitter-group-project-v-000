require './config/environment'

class LoginController < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/login/index'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      slug = user.slug
      redirect "/tweets"
    else
      redirect "/login/index"
    end
  end

end
