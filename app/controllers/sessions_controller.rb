class SessionsController < ApplicationController
  protect_from_forgery :except => [:create]
  skip_before_filter :require_authentication, :only => [:create, :logout]
  
  def create
    user = User.authenticate(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to session[:return_to] || '/'
  end
  
  def logout
    if this_session = Session.find_by_session_id(request.session_options[:id])
      this_session.destroy()
    end
    redirect_to :login
  end

 end
