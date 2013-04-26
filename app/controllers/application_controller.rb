class ApplicationController < ActionController::Base
  def current_user
  @current_user ||= User.find(session[:userid]) if session[:userid]

end
end
