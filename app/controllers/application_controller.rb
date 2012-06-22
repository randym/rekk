class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_authentication
 
  def require_authentication
    if current_user
      return true
    else
      session[:return_to] = request.original_fullpath
      redirect_to '/auth/google_apps' # controller: :sessions, :action => :login
      return false
    end
  end

  def current_user
    return false unless session[:user_id]
    @current_user = User.find(session[:user_id])
  end

end
