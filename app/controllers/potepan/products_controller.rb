class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.in_taxons(@product.taxons.ids).
      distinct.where.not(id: @product.id).limit(MAX_RELATED_PRODUCTS)
  end
end
