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

    it "showテンプレートを返すこと" do
      expect(response).to render_template :show
    end

    it '@productがアサインされること' do
      expect(assigns(:product)).to eq product
    end
  end
end
