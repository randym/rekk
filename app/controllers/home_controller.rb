class HomeController < ApplicationController
  protect_from_forgery

  def index
    @user = current_user
  end

  def login
  end
end

