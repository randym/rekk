class ProductsController < ApplicationController
  protect_from_forgery
  before_filter :products_list, only: [:new, :show, :index]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    redirect_to products_path if product.save
    flash[:error] = product.errors.map { |k, v| "#{k}: #{v}" }
    redirect_to new_product_path(product) 
  end

  def update
    product = Product.find(params[:id])
    product.update_attributes!(params[:product])
    redirect_to edit_product_path(product)
  end 


  private
  def products_list
    @products = params[:alternate] ? Product.active : Product.all
  end
end
