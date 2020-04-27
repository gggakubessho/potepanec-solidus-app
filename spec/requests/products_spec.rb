require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET #show" do
    include_context "category setup"

    before do
      get potepan_product_path(product.id)
    end

    it "200 OK レスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "商品名が含まれていること" do
      expect(response.body).to include "SmapleProduct"
    end

    it '商品説明が含まれていること' do
      expect(response.body).to include "test"
    end

    it '商品金額が含まれていること' do
      expect(response.body).to include "23.45"
    end
  end
end
