class Potepan::Api::SuggestsController < ApplicationController
  before_action -> { authenticate("SUGGESTS_API_KEY") }
  LIMIT_MAX_NUM = 20

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
    max_num = max_num.to_i.positive? ? max_num : LIMIT_MAX_NUM
    keywords = Potepan::PotepanSuggest.where(['keyword like ?', "#{keyword}%"])
    keywords = keywords.limit(max_num)
    keywords.pluck(:keyword)
  end
end
