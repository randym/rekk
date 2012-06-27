class ProductTypesController < ApplicationController
  def index
    @product_types = params[:alternate] ?  ProductType.active : ProductType.all
  end

  def new
    @product_type = ProductType.new
  end

  def edit
    @product_type = ProductType.find(params[:id])
  end

  def show
    @product_type = ProductType.find(params[:id])
  end
end
