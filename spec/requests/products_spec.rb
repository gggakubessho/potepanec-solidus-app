require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET #show" do
    let!(:product) do
      create(:product,
             name: "SmapleProduct",
             description: "test",
             price: "23.45")
    end

    before do
      get potepan_product_path(product.id)
    end

    it "200 OK レスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "商品名が表示されること" do
      expect(response.body).to include "SmapleProduct"
    end

    it '商品説明が表示されること' do
      expect(response.body).to include "test"
    end

    it '商品金額が表示されること' do
      expect(response.body).to include "23.45"
    end
  end
end
