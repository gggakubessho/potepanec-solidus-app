require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "displayed full title" do
      expect(full_title(page_title: "test")).to eq "test - BIGBAG Store"
      expect(full_title(page_title: "")).to eq "BIGBAG Store"
    end
  end
end
