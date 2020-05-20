class Potepan::Api::SuggestsController < ApplicationController
  before_action -> { authenticate("SUGGESTS_API_KEY") }
  def index
    if params[:keyword]
      @products = search_keyword(params[:keyword], params[:max_num])
      render json: @products
    else
      api_error_handler(500)
    end
  end

  private

  def search_keyword(keyword, max_num)
    return [] if keyword.blank?
    limit = true if max_num.present? && max_num.to_i > 1
    keywords = Potepan::PotepanSuggest.select(:keyword).where(['keyword like ?', "#{keyword}%"])
    keywords = keywords.limit(max_num) if limit
    keywords.pluck(:keyword).to_json
  end
end
