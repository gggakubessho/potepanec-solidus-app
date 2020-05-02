class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.in_taxons(@product.taxons.ids).
      uniq_products_without_self(@product).limit(MAX_RELATED_PRODUCTS)
  end
end
