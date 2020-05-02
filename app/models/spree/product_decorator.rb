Spree::Product.class_eval do
  scope :uniq_products_without_self, ->(product) { distinct.where.not(id: product.id) }
end
