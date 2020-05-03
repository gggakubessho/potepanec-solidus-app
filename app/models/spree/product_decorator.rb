Spree::Product.class_eval do
  scope :related_products, ->(product) do
    in_taxons(product.taxons.ids).distinct.where.not(id: product.id)
  end
end
