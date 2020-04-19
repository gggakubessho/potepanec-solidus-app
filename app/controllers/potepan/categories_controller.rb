class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.all
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products
  end
end
