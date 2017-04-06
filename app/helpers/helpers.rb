require './config/environment'

class Helpers
  def self.is_logged_in?
    !!session[:user_id]
  end
end