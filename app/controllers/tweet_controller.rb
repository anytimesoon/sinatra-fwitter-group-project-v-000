require './config/environment'

class TweetController < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/tweet' do
    if Helpers.is_logged_in?
      'hello world'
    else
      redirect '/signup'
    end
  end

end
