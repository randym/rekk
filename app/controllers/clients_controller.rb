class ClientsController < ApplicationController
  protect_from_forgery

  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end
  def create
    @client = Client.new(params['client'])
    @client.save
    redirect_to clients_path
  end 
  def show
@client = Client.find(params[:id])

  end
  def new
    @client = Client.new(:user => current_user)
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    puts params[:client]
    @client.update_attributes(params[:client])
    render(:action => :edit)
  end
  
  def destroy

  end
end
