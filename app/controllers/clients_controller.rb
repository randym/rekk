class ClientsController < ApplicationController
  protect_from_forgery
  before_filter :clients_list, only: [:show, :new, :index]
 
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  def create
    client = Client.new(params['client'])
    client.save!
    redirect_to clients_path
  end 
 
  def show
    @client = Client.find(params[:id])
  end
 
  def new
   @client = Client.new(:user => current_user)
  end

  def update
    client = Client.find(params[:id])
    client.update_attributes(params[:client])
    flash[:sucess] = "woot!"
    redirect_to client_path(client)
  end
  
  def destroy
    client = Client.find(params[:id])
    client.destroy
    redirect_to clients_path
  end

  private
  def clients_list
    @clients = params[:alternate] ? Client.by_user(current_user) : Client.all
  end


end
