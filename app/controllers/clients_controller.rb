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
     contacts = params['client'].delete(:contacts)
    @client = Client.new(params['client'])
    @client.save
    contacts.each do |contact| 
      contact = Contact.new(contact)
      contact.client = @client
      contact.save()
    end
    redirect_to clients_path
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
