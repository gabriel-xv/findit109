class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @new_product = Product.new
  end

  def create
    @new_product = Product.new(product_params)
    @new_product.user = current_user

    if @new_product.save
      redirect_to product_path(@new_product)
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :condition, :photo)
  end
end
