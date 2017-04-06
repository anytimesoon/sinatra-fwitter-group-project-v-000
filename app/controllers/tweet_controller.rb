require './config/environment'

class TweetController < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/tweets' do
    binding.pry
    if Helpers.is_logged_in?(session)
      'hello world'
    else
      redirect '/signup'
    end
  end

end
