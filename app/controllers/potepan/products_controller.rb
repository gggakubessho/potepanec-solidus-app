class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find_by(id: params[:id])
  end
end
