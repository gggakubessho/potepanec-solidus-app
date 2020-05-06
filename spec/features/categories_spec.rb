require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  include_context "category setup"

  background do
    visit potepan_category_path(rails_taxon.id)
  end

  feature "商品カテゴリページ" do
    # HOMEリンクへの遷移
    include_context "HOME link"

    scenario "カテゴリとカテゴリに紐つく商品一覧が表示されること" do
      within find(".pageHeader") do
        within find(".page-title") do
          expect(page).to have_content rails_taxon.name
        end

        within find(".breadcrumb") do
          expect(page).to have_content rails_taxon.name
        end
      end

      within first(".panel-default") do
        # サイドバーに大カテゴリが表示される
        expect(page).to have_content taxonomy.name

        # サイドバーに小カテゴリが表示される
        expect(page).to have_content "#{rails_taxon.name} (#{rails_taxon.all_products.count})"
        expect(page).to have_content "#{bags_taxon.name} (#{bags_taxon.all_products.count})"
        expect(page).to have_content "#{mugs_taxon.name} (#{mugs_taxon.all_products.count})"
      end

      # カテゴリをクリック
      click_on mugs_taxon.name
      expect(page).to have_content rails_mug.name
      expect(page).to have_content rails_mug.display_price

      # 指定カテゴリ以外の商品は表示されない
      expect(page).not_to have_content rails_bag.name
      expect(page).not_to have_content rails_bag.display_price

      # 商品をクリック
      click_on rails_mug.name
      expect(current_path).to eq potepan_product_path(rails_mug.id)
    end
  end
end
