class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_authentication
    if current_user
      return true
    else
      #session[:return_to] = request.request_uri
      redirect_to '/auth/google_apps' # controller: :sessions, :action => :login
      return false
    end
  end

  def current_user
    return false unless session[:user_id]
    User.find(session[:user_id])
  end

end
