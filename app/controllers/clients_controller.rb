class ClientsController < ApplicationController
  protect_from_forgery

  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end
  
  def show

  end
  def new
    @client = Client.new()
  end
  def edit

  end

  def destroy

  end
end
