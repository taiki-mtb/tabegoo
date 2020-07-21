require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    before do
      visit root_path
    end

    it "ポートフォリオの文字列が存在すること" do
      expect(page).to have_content 'ポートフォリオ'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title
    end
  end
end
