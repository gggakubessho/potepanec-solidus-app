require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given!(:product) do
    create(:product, name: "SmapleProduct", description: "test", price: "23.45")
  end

  background do
    visit potepan_product_path(product.id)
  end

  feature "商品詳細ページ" do
    include_context "HOME link"

    scenario ".lightSection内で商品名が表示されること" do
      within find(".pageHeader") do
        within find(".page-title") do
          expect(page).to have_content product.name
        end

        within find(".breadcrumb") do
          expect(page).to have_content product.name
        end
      end
    end

    scenario ".mainContent内にに対象商品のデータが表示されること" do
      within find('.mainContent') do
        expect(page).to have_content product.name
        expect(page).to have_content product.description
        expect(page).to have_content product.display_price
      end
    end
  end
end
