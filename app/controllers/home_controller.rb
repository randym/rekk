class HomeController < ApplicationController
  before_filter :require_authentication, :only => [:index]
  
  def index
    @user = current_user
  end
end

