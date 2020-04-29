RSpec.shared_context "category setup" do
  let!(:taxonomy)    { create(:taxonomy, name: 'Categories') }
  let!(:rails_taxon) { create(:taxon, name: 'Ruby on Rails', parent_id: taxonomy.root.id) }
  let!(:bags_taxon)  { create(:taxon, name: 'Bags', parent_id: taxonomy.root.id) }
  let!(:mugs_taxon)  { create(:taxon, name: 'Mugs', parent_id: taxonomy.root.id) }
  let!(:product) do
    create(:custom_product,
           name: "SmapleProduct", description: "test", price: "23.45", taxons: [rails_taxon])
  end
  let!(:rails_bag) do
    create(:custom_product, name: 'Rails Bag', price: '22.99', taxons: [bags_taxon])
  end
  let!(:rails_mug) do
    create(:custom_product, name: 'Rails Mug', price: '19.99', taxons: [mugs_taxon])
  end
  let!(:related_products) do
    create_list(:custom_product, 4, name: "Related Product", price: '99.99', taxons: [rails_taxon])
  end
  let!(:non_taxon_product) do
    create(:custom_product,
           name: "Non Taxon Product", price: "33.33")
  end
end
