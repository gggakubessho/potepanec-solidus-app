require 'rails_helper'

RSpec.describe "Suggests", type: :request do
  describe "GET #index" do
    api_key = ENV["POTEPAN_API_KEY"]
    req_info = Potepan::Request::SuggestsRequest.opts
    let(:url) { ENV["POTEPAN_API_URI"] + req_info[:path] }
    let(:headers) { { Authorization: "Bearer #{api_key}" } }
    let(:base_stub) do
      stub_request(:get, url).with(headers: headers, query: query).
        to_return(
          status: status,
          body: api_res_body
        )
    end

    context "レスポンスコード200OKの場合" do
      subject do
        get potepan_api_suggests_path, params: query
        response
      end

      let(:query) { { keyword: "r", max_num: 5 } }
      let(:status) { 200 }
      let(:api_res_body) { ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"] }

      before do
        base_stub
      end

      it "apiの内容をレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body)).to eq api_res_body
      end
    end

    context "レスポンスコード400エラーの場合" do
      subject do
        get potepan_api_suggests_path, params: query
        response
      end

      let(:query) { { keyword: "400", max_num: 5 } }
      let(:status) { 400 }
      let(:api_res_body) { ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"] }

      before do
        base_stub
      end

      it "ステータス400とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Bad Request"
      end
    end

    context "レスポンスコード401エラーの場合" do
      subject do
        get potepan_api_suggests_path, params: query
        response
      end

      let(:query) { { keyword: "401", max_num: 5 } }
      let(:status) { 401 }
      let(:api_res_body) { "unauthorized" }

      before do
        base_stub
      end

      it "ステータス401とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Unauthorized"
      end
    end

    context "レスポンスコード404エラーの場合" do
      subject do
        get potepan_api_suggests_path, params: query
        response
      end

      let(:query) { { keyword: "404", max_num: 5 } }
      let(:status) { 404 }
      let(:api_res_body) { "Not Found" }

      before do
        base_stub
      end

      it "ステータス404とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Not Found"
      end
    end

    context "レスポンスコード500エラーの場合" do
      subject do
        get potepan_api_suggests_path, params: query
        response
      end

      let(:query) { { "keyword" => "", "max_num" => 5 } }
      let(:status) { 500 }
      let(:api_res_body) { "unexpected error" }

      before do
        base_stub
      end

      it "ステータス500とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Internal Server Error"
      end
    end
  end
end
