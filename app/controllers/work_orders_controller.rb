class WorkOrdersController < ApplicationController
  protect_from_forgery
  before_filter :work_orders_list, only: [:index]
  # GET /work_orders
  # GET /work_orders.json
  def index
    # how to deal with search, selfish and status params?
    @clients = Client.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @work_orders }
    end
  end

  # GET /work_orders/1
  # GET /work_orders/1.json
  def show
    @work_order = WorkOrder.find(params[:id], include: :payment)
    # This feels wrong - the payment object must be created or we cannot render the nested form
    @work_order.payment ||= Payment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_order }
    end
  end

  # GET /work_orders/new
  # GET /work_orders/new.json
  def new
    @work_order = WorkOrder.new
    @work_order.author = current_user
    @work_order.payment ||= Payment.new
    @work_order.client = Client.find(params[:client_id]) if params[:client_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_order }
    end
  end

  # POST /work_orders
  # POST /work_orders.json
  def create
    @work_order = WorkOrder.new(params[:work_order])

    respond_to do |format|
      if @work_order.save
        format.html { redirect_to @work_order, notice: 'Work order was successfully created.' }
        format.json { render json: @work_order, status: :created, location: @work_order }
      else
        format.html { render action: "new" }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work_orders/1
  # PUT /work_orders/1.json
  def update
    @work_order = WorkOrder.find(params[:id])

    respond_to do |format|
      puts params[:work_order]
      if @work_order.update_attributes(params[:work_order])
        format.html { redirect_to @work_order, notice: 'Work order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_orders/1
  # DELETE /work_orders/1.json
  def destroy
    @work_order = WorkOrder.find(params[:id])
    @work_order.destroy

    respond_to do |format|
      format.html { redirect_to work_orders_url }
      format.json { head :no_content }
    end
  end
  private
  def work_orders_list
    params[:owner_id] = current_user.id if params[:selfish] == "true"
    puts params
    @work_orders = WorkOrder.search(params).page(params[:page])
  end
end
