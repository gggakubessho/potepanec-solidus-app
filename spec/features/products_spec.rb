require 'rails_helper'

RSpec.feature "Products", type: :feature do
  include_context "category setup"

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

    scenario "一覧ページに遷移すること" do
      click_on "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(product.taxons.first.id)
    end

    scenario ".mainContent内にに対象商品のデータが表示されること" do
      within find('.mainContent') do
        expect(page).to have_content product.name
        expect(page).to have_content product.description
        expect(page).to have_content product.display_price
      end
    end

    scenario "関連商品が表示されること" do
      within find('.productsContent') do
        expect(all('.productBox')[0]).to have_content related_products[0].name
        expect(all('.productBox')[0]).to have_content related_products[0].price
        expect(page).to have_link nil, href: potepan_product_path(related_products[0].id)

        expect(all('.productBox')[1]).to have_content related_products[1].name
        expect(all('.productBox')[1]).to have_content related_products[1].price
        expect(page).to have_link nil, href: potepan_product_path(related_products[1].id)

        expect(all('.productBox')[2]).to have_content related_products[2].name
        expect(all('.productBox')[2]).to have_content related_products[2].price
        expect(page).to have_link nil, href: potepan_product_path(related_products[2].id)

        expect(all('.productBox')[3]).to have_content related_products[3].name
        expect(all('.productBox')[3]).to have_content related_products[3].price
        expect(page).to have_link nil, href: potepan_product_path(related_products[3].id)
      end
    end

    scenario "商品詳細と同じ商品が関連商品に表示されないこと" do
      within find('.productsContent') do
        expect(all('.productBox')[0]).not_to have_content product.name
        expect(all('.productBox')[0]).not_to have_content product.price
        expect(page).not_to have_link nil, href: potepan_product_path(product.id)
      end
    end

    scenario "関連商品から商品詳細ページに遷移すること" do
      within find('.productsContent') do
        all('a')[0].click
      end
      expect(current_path).to eq potepan_product_path(related_products[0].id)
    end

    scenario "関連商品が4つ以下で表示されること" do
      within find('.productsContent') do
        expect(all('.productBox').size).to eq(4)
      end
    end

    scenario "taxonが存在しない商品の場合でも関連商品(全商品)が4つ表示されること" do
      visit potepan_product_path(non_taxon_product.id)
      expect(current_path).to eq potepan_product_path(non_taxon_product.id)
      within find('.productsContent') do
        expect(all('.productBox').size).to eq(4)
      end
    end
  end
end
