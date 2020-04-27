require 'rails_helper'

RSpec.describe "Categories", type: :request do
  include_context "category setup"

  describe "GET #show" do
    before do
      get potepan_category_path(mugs_taxon.id)
    end

    it "200 OK レスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    context "指定カテゴリの商品" do
      it "指定カテゴリの商品名が含まれていること" do
        expect(response.body).to include "Rails Mug"
      end

      it "指定カテゴリの商品金額が含まれていること" do
        expect(response.body).to include "19.99"
      end
    end

    context "指定カテゴリ以外の商品" do
      it "指定カテゴリ以外の商品名が含まれていないこと" do
        expect(response.body).not_to include "Rails Bag"
      end

      it "指定カテゴリ以外の商品金額が含まれていないこと" do
        expect(response.body).not_to include "22.99"
      end
    end
  end
end
