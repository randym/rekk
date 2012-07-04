class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_authentication, except: [:login]
 
  def require_authentication
    if current_user
      return true
    else
      session[:return_to] = request.original_fullpath
      redirect_to :login
      return false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
