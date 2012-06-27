class ProductTypesController < ApplicationController
  protect_from_forgery
  before_filter :product_types_list, only: [:index, :show, :new]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_types }
    end
  end

  def new
    @product_type = ProductType.new
  end

  def create
    product_type = ProductType.new(params[:product_type])
    product_type.save!
    redirect_to product_types_path
  end

  def show
    @product_type = ProductType.find(params[:id])
  end

  def update
    product_type = ProductType.find(params[:id])
    product_type.update_attributes(params[:product_type])
    redirect_to edit_product_type_path(product_type)
  end

  private

  def product_types_list
    @product_types = params[:alternate] ?  ProductType.active : ProductType.all
  end
end
