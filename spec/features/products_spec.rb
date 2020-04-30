require 'rails_helper'

RSpec.feature "Products", type: :feature do
  include_context "category setup"

  background do
    visit potepan_product_path(product.id)
  end

  feature "商品詳細ページ" do
    # HOMEリンクへの遷移
    include_context "HOME link"

    scenario "商品詳細エリアに商品が表示されること" do
      # .pageHeader内に商品名が表示される
      within find(".pageHeader") do
        within find(".page-title") do
          expect(page).to have_content product.name
        end

        within find(".breadcrumb") do
          expect(page).to have_content product.name
        end
      end

      # .mainContent内に商品情報が表示される
      within find('.mainContent') do
        expect(page).to have_content product.name
        expect(page).to have_content product.description
        expect(page).to have_content product.display_price
      end

      # カテゴリ一覧ページへの遷移
      click_on "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(product.taxons.first.id)
    end

    context "taxon有りの関連商品の場合" do
      scenario "同カテゴリの関連商品が4つ表示されること" do
        within find('.productsContent') do
          # 同カテゴリの商品が表示される
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

          # 異カテゴリの商品は表示されない
          expect(all('.productBox')[0]).not_to have_content product.name
          expect(all('.productBox')[0]).not_to have_content product.price
          expect(page).not_to have_link nil, href: potepan_product_path(product.id)

          # 関連商品が4つ表示される
          expect(all('.productBox').size).to eq(4)

          # 商品詳細ページへの遷移
          all('a')[0].click
          expect(current_path).to eq potepan_product_path(related_products[0].id)
        end
      end
    end

    context "taxon無しの関連商品の場合" do
      scenario "異カテゴリの関連商品が4つ表示されること" do
        visit potepan_product_path(non_taxon_product.id)
        expect(current_path).to eq potepan_product_path(non_taxon_product.id)
        within find('.productsContent') do
          # 関連商品が4つ表示される
          expect(all('.productBox').size).to eq(4)
        end
      end
    end
  end
end
