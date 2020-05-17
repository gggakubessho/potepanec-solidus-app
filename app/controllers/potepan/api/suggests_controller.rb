class Potepan::Api::SuggestsController < ApplicationController
  before_action -> { authenticate("SUGGESTS_API_KEY") }
  def index
    if params[:keyword]
      @products = search_product(params[:keyword], params[:max_num])
      render json: @products
    else
      api_error_handler(500)
    end
  end

  private

  def search_product(keyword, max_num)
    return [] if keyword.blank?
    @product = Potepan::PotepanSuggest.select(:keyword).where(['keyword like ?', "#{keyword}%"])
    if max_num.present?
      @product = @product.limit(max_num)
    end
    @product.pluck(:keyword).to_json
  end
end
