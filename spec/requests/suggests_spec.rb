require 'rails_helper'

RSpec.describe "Suggests", type: :request do
  describe "GET #index" do
    api_key = ENV["POTEPAN_API_KEY"]
    req_info = Potepan::Request::SuggestsRequest.opts
    url = ENV["POTEPAN_API_URI"] + req_info[:path]
    headers = { "Authorization" => "Bearer #{api_key}" }

    context "レスポンスコード200OKの場合" do
      query = { "keyword" => "r", "max_num" => 5 }
      status = 200
      api_res_body = ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]

      before do
        stub_request(:get, url).with(headers: headers, query: query).
          to_return(
            status: status,
            body: api_res_body
          )
        get potepan_suggests_path, params: query
      end

      it "レスポンスコード200を返すこと" do
        expect(response).to have_http_status status
      end

      it "apiの内容をレスポンスbodyとして返すこと" do
        expect(JSON.parse(response.body)).to eq api_res_body
      end
    end

    context "レスポンスコード400エラーの場合" do
      query = { "keyword" => "400", "max_num" => 5 }
      status = 400

      before do
        stub_request(:get, url).with(headers: headers, query: query).
          to_return(
            status: status
          )
        get potepan_suggests_path, params: query
      end

      it "レスポンスコード400を返すこと" do
        expect(response).to have_http_status status
      end

      it "ステータス400とエラーメッセージをレスポンスbodyとして返すこと" do
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Bad Request"
      end
    end

    context "レスポンスコード401エラーの場合" do
      query = { "keyword" => "401", "max_num" => 5 }
      status = 401

      before do
        stub_request(:get, url).with(headers: headers, query: query).
          to_return(
            status: status
          )
        get potepan_suggests_path, params: query
      end

      it "レスポンスコード401を返すこと" do
        expect(response).to have_http_status status
      end

      it "ステータス401とエラーメッセージをレスポンスbodyとして返すこと" do
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Unauthorized"
      end
    end

    context "レスポンスコード404エラーの場合" do
      query = { "keyword" => "404", "max_num" => 5 }
      status = 404

      before do
        stub_request(:get, url).with(headers: headers, query: query).
          to_return(
            status: status
          )
        get potepan_suggests_path, params: query
      end

      it "レスポンスコード404を返すこと" do
        expect(response).to have_http_status status
      end

      it "ステータス404とエラーメッセージをレスポンスbodyとして返すこと" do
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Not Found"
      end
    end

    context "レスポンスコード500エラーの場合" do
      query = { "keyword" => "", "max_num" => 5 }
      status = 500

      before do
        stub_request(:get, url).with(headers: headers, query: query).
          to_return(
            status: status
          )
        get potepan_suggests_path, params: query
      end

      it "レスポンスコード500を返すこと" do
        expect(response).to have_http_status status
      end

      it "ステータス500とエラーメッセージをレスポンスbodyとして返すこと" do
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Internal Server Error"
      end
    end
  end
end
