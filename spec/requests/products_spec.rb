require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET #show" do
    include_context "category setup"

    before do
      get potepan_product_path(product.id)
    end

    it "taxonが存在する商品で200OK レスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "taxonが存在しない商品で200OK レスポンスを返すこと" do
      get potepan_product_path(non_taxon_product.id)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "商品名が含まれていること" do
      expect(response.body).to include product.name
    end

    it '商品説明が含まれていること' do
      expect(response.body).to include product.description
    end

    it '商品金額が含まれていること' do
      expect(response.body).to include product.price.to_s
    end

    it "同一カテゴリの商品が関連する商品として含まれていること" do
      expect(response.body).to include related_products[0].name
      expect(response.body).to include related_products[0].price.to_s
    end

    it "異なるカテゴリの商品が関連しない商品として含まれていないこと" do
      expect(response.body).not_to include rails_bag.name
      expect(response.body).not_to include rails_bag.price.to_s
    end
  end
end
