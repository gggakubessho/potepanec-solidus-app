require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let!(:taxonomy)    { create(:taxonomy, name: 'Categories') }
  let!(:rails_taxon) { create(:taxon, name: 'Ruby on Rails', parent_id: taxonomy.root.id) }
  let!(:bags_taxon)  { create(:taxon, name: 'Bags', parent_id: taxonomy.root.id) }
  let!(:mugs_taxon)  { create(:taxon, name: 'Mugs', parent_id: taxonomy.root.id) }
  let!(:rails_bag)   do
    create(:custom_product, name: 'Rails Bag', price: '22.99',
                            taxons: [rails_taxon, bags_taxon])
  end
  let!(:rails_mug) do
    create(:custom_product, name: 'Rails Mug', price: '19.99',
                            taxons: [rails_taxon, mugs_taxon])
  end

  background do
    visit potepan_category_path(rails_taxon.id)
  end

  feature "商品カテゴリページ" do
    scenario ".header内のリンクがトップページに遷移すること" do
      within find('.navbar-header') do
        click_on "HOME"
        expect(current_path).to eq potepan_path
      end

      within find('.navbar-collapse') do
        click_on "HOME"
        expect(current_path).to eq potepan_path
      end
    end

    scenario ".lightSectionにてリンクがトップページに遷移すること" do
      within find('.pageHeader') do
        click_on "HOME"
        expect(current_path).to eq potepan_path
      end
    end

    scenario ".lightSection内でカテゴリ名が表示されること" do
      within find(".pageHeader") do
        within find(".page-title") do
          expect(page).to have_content rails_taxon.name
        end

        within find(".breadcrumb") do
          expect(page).to have_content rails_taxon.name
        end
      end
    end

    scenario "サイドバーにtaxonomyが表示されること" do
      within first(".panel-default") do
        expect(page).to have_content taxonomy.name
      end
    end

    scenario "サイドバーにtaxonが表示されること" do
      within first(".panel-default") do
        expect(page).to have_content "#{rails_taxon.name} (#{rails_taxon.all_products.count})"
        expect(page).to have_content "#{bags_taxon.name} (#{bags_taxon.all_products.count})"
        expect(page).to have_content "#{mugs_taxon.name} (#{mugs_taxon.all_products.count})"
      end
    end

    scenario "指定カテゴリの商品が表示されること" do
      click_on mugs_taxon.name
      expect(page).to have_content rails_mug.name
      expect(page).to have_content rails_mug.display_price
    end

    scenario "指定カテゴリ以外の商品が表示されないこと" do
      click_on mugs_taxon.name
      expect(page).not_to have_content rails_bag.name
      expect(page).not_to have_content rails_bag.display_price
    end

    scenario "商品をクリックすると商品詳細ページに遷移すること" do
      click_on mugs_taxon.name
      click_on rails_mug.name
      expect(current_path).to eq potepan_product_path(rails_mug.id)
    end
  end
end
