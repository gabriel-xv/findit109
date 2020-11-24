class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude
      }
    end
  end

  def show
    @product = Product.find(params[:id])
    @markers = [
      {
        lat: @product.latitude,
        lng: @product.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { product: @product }),
        image_url: helpers.asset_url('')
      }
    ]
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
    params.require(:product).permit(:name, :description, :price, :condition, :address, :lat, :lng, :photo)
  end
end
