class Potepan::Api::SuggestsController < ApplicationController
  before_action -> { authenticate("SUGGESTS_API_KEY") }
  def index
    if params[:keyword]
      keywords = search_keyword(params[:keyword], params[:max_num])
      render json: keywords
    else
      api_error_handler(500)
    end
  end

  private

  def search_keyword(keyword, max_num)
    return [] if keyword.blank?
    keywords = Potepan::PotepanSuggest.select(:keyword).where(['keyword like ?', "#{keyword}%"])
    keywords = keywords.limit(max_num) if max_num.to_i >= 1
    keywords.pluck(:keyword).to_json
  end
end
