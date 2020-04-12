require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "Title" do
    it "#full_title" do
      expect(full_title(page_title: "test")).to eq "test - BIGBAG Store"
      expect(full_title(page_title: "")).to eq "BIGBAG Store"
    end
  end
end
