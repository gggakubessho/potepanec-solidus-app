class Potepan::Api::SuggestsController < ApplicationController
  def index
    api_params = {}
    api_params[:keyword] = params[:keyword]
    api_params[:max_num] = params[:max_num]
    suggest_request = Potepan::Request::SuggestsRequest.build(api_params)
    res = suggest_request.send
    status = res.status
    if status == 200
      render status: status, json: res.body
    else
      api_error_handler(status)
    end
  end
end
