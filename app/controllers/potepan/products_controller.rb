class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find_by(id: params[:id])
    @master_images = @product.master_images
  end
end
