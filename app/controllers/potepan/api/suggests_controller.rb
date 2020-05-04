class Potepan::Api::SuggestsController < ApplicationController
  require 'httpclient'
  def index
    client = HTTPClient.new
    uri = 'https://presite-potepanec-task5.herokuapp.com/potepan/api/suggests'
    key = ENV["POTEPAN_API_KEY"]
    query = { 'keyword' => 'r', 'max_num' => 5 }
    header = { 'Authorization' => "Bearer #{key}" }
    @sgst_res = client.get(uri, query: query, header: header).body
  end
end
