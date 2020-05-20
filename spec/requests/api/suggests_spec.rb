require 'rails_helper'

RSpec.describe "Suggests", type: :request do
  describe "GET #index" do
    api_key = ENV["SUGGESTS_API_KEY"]

    subject do
      get potepan_api_suggests_path, params: query, headers: headers
      response
    end

    let!(:suggest_keywords) do
      create(:potepan_suggest, keyword: "Rails ruby")
      create_list(:potepan_suggest, 5)
    end
    let!(:unmatch_keyword) { "Rails ruby" }

    context "正常系(keywordマッチ有り&max_num有り)の場合" do
      let(:query) { { keyword: "ruby", max_num: 5 } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "max_numの数だけ返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq query[:max_num]
      end
    end

    context "正常系(keywordマッチなし)の場合" do
      let(:query) { { keyword: "test", max_num: 5 } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "空の配列を返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body)).to eq []
      end
    end

    context "正常系(keyword空)の場合" do
      let(:query) { { keyword: "", max_num: 5 } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "空の配列を返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body)).to eq []
      end
    end

    context "正常系(max_num存在なし)の場合" do
      let(:query) { { keyword: "ruby" } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq Potepan::PotepanSuggest.
          where(['keyword like ?', "#{query[:keyword]}%"]).count
      end
    end

    context "正常系(max_num空)の場合" do
      let(:query) { { keyword: "ruby", max_num: "" } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq Potepan::PotepanSuggest.
          where(['keyword like ?', "#{query[:keyword]}%"]).count
      end
    end

    context "正常系(max_numが文字列)の場合" do
      let(:query) { { keyword: "ruby", max_num: "てすと" } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq Potepan::PotepanSuggest.
          where(['keyword like ?', "#{query[:keyword]}%"]).count
      end
    end

    context "正常系(max_numが-1)の場合" do
      let(:query) { { keyword: "ruby", max_num: -1 } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq Potepan::PotepanSuggest.
          where(['keyword like ?', "#{query[:keyword]}%"]).count
      end
    end

    context "正常系(max_numが0)の場合" do
      let(:query) { { keyword: "ruby", max_num: 0 } }
      let(:status) { 200 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        suggest_keywords.each do |suggest_keyword|
          expect(res).to include suggest_keyword.keyword
        end
        expect(res).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(JSON.parse(response.body).size).to eq Potepan::PotepanSuggest.
          where(['keyword like ?', "#{query[:keyword]}%"]).count
      end
    end

    context "異常系(keyword存在なし)の場合" do
      let(:query) { { max_num: 5 } }
      let(:status) { 500 }
      let(:headers) { { Authorization: "Bearer #{api_key}" } }

      it "ステータス500とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        expect(res["status"]).to eq status
        expect(res["message"]).to eq "Internal Server Error"
      end
    end

    context "異常系(認証が不正な場合)の場合" do
      let(:query) { { keyword: "401", max_num: 5 } }
      let(:status) { 401 }
      let(:headers) { { Authorization: "Bearer api111" } }

      it "ステータス401とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        res = JSON.parse(response.body)
        expect(res["status"]).to eq status
        expect(res["message"]).to eq "Unauthorized"
      end
    end
  end
end
