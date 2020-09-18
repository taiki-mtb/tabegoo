require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }

  describe "トップページ" do
    before do
      create_list(:restaurant, 10)
      visit root_path
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title
    end

    context "管理者ユーザーの場合" do
      it "「新しいお店の登録」リンクが表示されること" do
        login_for_system(admin_user)
        expect(page).to have_link "新しいお店の登録", href: new_restaurant_path
      end
    end

    context "管理者以外のユーザーの場合" do
      it "「新しいお店の登録」リンクが表示されないこと" do
        login_for_system(user)
        expect(page).not_to have_link "新しいお店の登録"
      end
    end

    context "料理フィード" do
      it "レストランの情報が表示されていることを確認" do
        Restaurant.take(5).each do |restaurant|
          expect(page).to have_link restaurant.name
          expect(page).to have_content restaurant.description
        end
      end

      it "レストランのページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end
  end
end
