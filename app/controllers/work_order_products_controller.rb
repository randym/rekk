class WorkOrderProductsController < ApplicationController
  before_filter :find_work_order, only: [:index, :new, :create, :update]
  before_filter :load_products, only: [:new, :create, :update]
  # Get /work_order_products
  # Get /work_order_products.json
  def index
    @products = @work_order.work_order_products.all
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  # GET /work_order_products/#id/edit
  # GET /work_order_products/#id/edit.json
  def edit
    @product = WorkOrderProduct.find(params[:id])
    respond_to do |format|
      format.html { render action: "new", layout: false }
      format.json { render json: @product }
    end
  end

  # GET /work_order_products/new
  # GET /work_order_products/new.json
  def new
    @work_order_product = WorkOrderProduct.new(options_for_work_order)
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @work_order_product }
    end
  end

  # DELETE /work_order_products/#id
  def destroy
    @product = WorkOrderProduct.find(params[:id])
    @product.destroy
    render nothing: true
  end

  # GET /comments/
  def create
    @work_order_product = WorkOrderProduct.find_or_initialize_by_id(params[:id])
    @work_order_product.update_attributes(params[:work_order_product])
    respond_to do |format|
      if @work_order_product.save
        format.html { render action: "show", layout: false }
        format.json { render json: @work_order_product }
      else
        format.html { render action: "new", layout: false }
        format.json { render json: @work_order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    create
  end

  private
  def load_products
    @products = Product.all
  end

  def find_work_order
    @work_order = WorkOrder.find_by_id(params[:work_order_id] || params[:work_order_product][:work_order_id])
  end

  def options_for_work_order
    { work_order_id: @work_order.id }
  end
end
