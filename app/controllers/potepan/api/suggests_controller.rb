class Potepan::Api::SuggestsController < ApplicationController
  def index
    params = {}
    params[:keyword] = "r"
    params[:max_num] = 5
    con = Potepan::Request::SuggestsRequest.build(params)
    @sgst_res = Potepan::APIRequest.send(con)
  end
end
