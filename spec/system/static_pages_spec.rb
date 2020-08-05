require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  
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

    context "管理者ユーザーの場合" do
      it "「新しいレストランの登録」リンクが表示されること" do
        login_for_system(admin_user)
        expect(page).to have_link "新しいレストランの登録", href: new_restaurant_path
      end
    end

    context "管理者以外のユーザーの場合" do
      it "「新しいレストランの登録」リンクが表示されないこと" do
        login_for_system(user)
        expect(page).not_to have_link "新しいレストランの登録"
      end
    end
  end
end
