class Potepan::SuggestsController < ApplicationController
  def index
    suggest_request = Potepan::Request::SuggestsRequest.build(suggest_params)
    begin
      res = suggest_request.send
      status = res.status
      if status == 200
        render status: status, json: res.body
      else
        api_error_handler(status)
      end
    rescue
      api_error_handler(500, err_msg: "request connection failed.")
    end
  end

  private

  def suggest_params
    params.permit(:keyword, :max_num)
  end
end
