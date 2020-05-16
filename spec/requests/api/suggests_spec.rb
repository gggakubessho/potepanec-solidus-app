require 'rails_helper'

RSpec.describe "Suggests", type: :request do
  describe "GET #index" do
    api_key = ENV["SUGGESTS_API_KEY"]

    context "正常系(keywordマッチ有り&max_num有り)の場合" do
      query = { "keyword" => "ruby","max_num" => 5 }
      status = 200
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータスコード200を返すこと" do
        is_expected.to have_http_status(status)
      end

      it "keywordに前方一致した商品名だけを返すこと" do
        
      end

      it "max_numの数だけ返すこと" do
        
      end
    end

    context "正常系(keywordマッチなし)の場合" do
      query = { "keyword" => "test","max_num" => 5 }
      status = 200
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータスコード200を返すこと" do
        is_expected.to have_http_status(status)
      end

      it "nilを返すこと" do
        expect(response).to be nil
      end
    end

    context "正常系(keyword空)の場合" do
      query = { "keyword" => "ruby","max_num" => 5 }
      status = 200
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータスコード200を返すこと" do
        is_expected.to have_http_status(status)
      end

      it "nilを返すこと" do
        expect(response).to be nil
      end
    end

    context "正常系(max_num存在なし)の場合" do
      query = { "keyword" => "ruby","max_num" => 5 }
      status = 200
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータスコード200を返すこと" do
        is_expected.to have_http_status(status)
      end

      it "keywordに前方一致した商品名だけを返すこと" do
        
      end

      it "keywordマッチした全データを返すこと" do
        
      end
    end

    context "正常系(max_num空)の場合" do
      query = { "keyword" => "ruby","max_num" => 5 }
      status = 200
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータスコード200を返すこと" do
        is_expected.to have_http_status(status)
      end

      it "keywordに前方一致した商品名だけを返すこと" do
        
      end

      it "keywordマッチした全データを返すこと" do
        
      end
    end

    context "異常系(keyword存在なし)の場合" do
      query = { "max_num" => 5 }
      status = 500
      headers = { "Authorization" => "Bearer #{api_key}" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータス500とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Internal Server Error"
      end

    end

    context "異常系(認証が不正な場合)の場合" do
      query = { "keyword" => "401", "max_num" => 5 }
      status = 401
      headers = { "Authorization" => "Bearer api111" }
      subject do
        get potepan_api_suggests_path, params: query,headers: headers
        response
      end

      it "ステータス401とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq status
        expect(json["message"]).to eq "Unauthorized"
      end

    end
  end
end
