class Potepan::SuggestsController < ApplicationController
  def index
    api_params = {}
    api_params[:keyword] = params[:keyword]
    api_params[:max_num] = params[:max_num]
    con = Potepan::Request::SuggestsRequest.build(api_params)
    res = Potepan::APIRequest.send(con)
    status = res.status
    if status == 200
      render status: status, json: res.body
    else
      case status
      when 400
        render status: status, json: { status: status, message: "Bad Request" }
      when 401
        render status: status, json: { status: status, message: "Unauthorized" }
      when 404
        render status: status, json: { status: status, message: "Not Found" }
      when 500..599
        render status: 500, json: { status: status, message: "Internal Server Error" }
      else
        render status: status, json: { status: status, message: "Sever Error" }
      end
    end
  end
end
