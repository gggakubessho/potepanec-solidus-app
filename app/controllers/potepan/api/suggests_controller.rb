class Potepan::Api::SuggestsController < ApplicationController
  def index
    params = {}
    params[:keyword] = "r"
    params[:max_num] = 5
    con = Potepan::Request::SuggestsRequest.build(params)
    res = Potepan::APIRequest.send(con)
    status = res.status

    if status == 200
      render status: status, json: { status: status, message: res.body }
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
