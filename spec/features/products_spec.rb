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
    scenario "headerにトップページへのリンクが存在すること" do
      within find('.header') do
        # トッページへのリンクが正しいこと
        expect(page).to have_current_path potepan_product_path(product.id)
      end
    end

    scenario "light sectionに商品名の表示とトップページへのリンクが存在すること" do
      within find('.lightSection') do
        # 商品名が表示されていること
        # トップページへのリンクが正しいこと
        expect(page).to have_content product.name
        expect(page).to have_current_path potepan_product_path(product.id)
      end
    end

    scenario "maincontent sectionに対象商品のデータが表示されること" do
      within find('.mainContent') do
        expect(page).to have_content product.name
        expect(page).to have_content product.description
        expect(page).to have_content product.display_price
      end
    end
  end
end
