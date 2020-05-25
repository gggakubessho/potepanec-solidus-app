require 'rails_helper'

RSpec.describe "Suggests", type: :request do
  describe "GET #index" do
    api_key = ENV["SUGGESTS_API_KEY"]

    subject { response }

    let!(:suggest_keywords) do
      create_list(:potepan_suggest, 10)
    end
    let!(:unmatch_keyword) { "Rails ruby" }
    let(:parsed_body) { JSON.parse(response.body) }
    let(:query) { { keyword: "ruby", max_num: 5 } }
    let(:status) { 200 }
    let(:headers) { { Authorization: "Bearer #{api_key}" } }

    before { get potepan_api_suggests_path, params: query, headers: headers }

    context "正常系(keywordマッチ有り&max_num有り)の場合" do
      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした数を最大max_numだけ返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 5
      end
    end

    context "正常系(keywordマッチなし)の場合" do
      let(:query) { { keyword: "test", max_num: 5 } }

      it "空の配列を返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body).to eq []
      end
    end

    context "正常系(keyword空)の場合" do
      let(:query) { { keyword: "", max_num: 5 } }

      it "空の配列を返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body).to eq []
      end
    end

    context "正常系(max_num存在なし)の場合" do
      let(:query) { { keyword: "ruby" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 10
      end
    end

    context "正常系(max_num空)の場合" do
      let(:query) { { keyword: "ruby", max_num: "" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 10
      end
    end

    context "正常系(max_numが文字列)の場合" do
      let(:query) { { keyword: "ruby", max_num: "てすと" } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 10
      end
    end

    context "正常系(max_numが-1)の場合" do
      let(:query) { { keyword: "ruby", max_num: -1 } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 10
      end
    end

    context "正常系(max_numが0)の場合" do
      let(:query) { { keyword: "ruby", max_num: 0 } }

      it "keywordに前方一致した商品名だけを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to be > 0
        parsed_body.each_with_index do |keyword, i|
          expect(keyword).to eq suggest_keywords[i].keyword
        end
        expect(parsed_body).not_to include unmatch_keyword
      end

      it "keywordマッチした全データを返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body.size).to eq 10
      end
    end

    context "異常系(keyword存在なし)の場合" do
      let(:query) { { max_num: 5 } }
      let(:status) { 500 }

      it "ステータス500とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body["status"]).to eq status
        expect(parsed_body["message"]).to eq "keyword parameters are required."
      end
    end

    context "異常系(認証が不正な場合)の場合" do
      let(:query) { { keyword: "401", max_num: 5 } }
      let(:status) { 401 }
      let(:headers) { { Authorization: "Bearer api111" } }

      it "ステータス401とエラーメッセージをレスポンスbodyとして返すこと" do
        is_expected.to have_http_status(status)
        expect(parsed_body["status"]).to eq status
        expect(parsed_body["message"]).to eq "Unauthorized"
      end
    end
  end
end
