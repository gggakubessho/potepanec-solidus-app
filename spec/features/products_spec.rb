require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given!(:product) do
    create(:product,
           name: "SmapleProduct",
           description: "test",
           price: "23.45")
  end
  background do
    visit potepan_product_path(product.id)
  end
  feature "製品詳細ページ" do
    scenario "header" do
      within find('.header') do
        # トッページへのリンクが正しいこと
        expect(page).to have_current_path potepan_product_path(product.id)
      end
    end
    scenario "light section" do
      within find('.lightSection') do
        # 商品名が表示されていること
        # トップページへのリンクが正しいこと
        expect(page).to have_content product.name
        expect(page).to have_current_path potepan_product_path(product.id)
      end
    end
    scenario "maincontent section" do
      within find('.mainContent') do
        # 商品名が表示されていること
        # 商品説明が表示されていること
        # 商品金額が表示されていること
        expect(page).to have_content product.name
        expect(page).to have_content product.description
        expect(page).to have_content product.display_price
      end
    end
  end
end
