RSpec.shared_context "HOME link" do
  scenario ".header内のリンクがトップページに遷移すること" do
    within find('.navbar-header') do
      click_on "HOME"
      expect(current_path).to eq potepan_path
    end

    within find('.navbar-collapse') do
      click_on "HOME"
      expect(current_path).to eq potepan_path
    end
  end

  scenario ".pageHeaderにてリンクがトップページに遷移すること" do
    within find('.pageHeader') do
      click_on "HOME"
      expect(current_path).to eq potepan_path
    end
  end
end
