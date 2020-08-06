require 'rails_helper'

RSpec.describe "Restaurants", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:restaurant) { create(:restaurant) }

  describe "レストラン登録ページ" do
    before do
      login_for_system(admin_user)
      visit new_restaurant_path
    end

    context "ページレイアウト" do
      it "「レストラン登録」の文字列が存在すること" do
        expect(page).to have_content 'レストラン登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('レストラン登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '名前'
        expect(page).to have_content '説明'
      end
    end

    context "レストラン登録処理" do
      it "有効な情報で登録を行うと登録成功のフラッシュが表示されること" do
        fill_in "名前", with: "レストラン"
        fill_in "説明", with: "冬に行きたい、身体が温まるレストランです"
        click_button "登録する"
        expect(page).to have_content "レストランが登録されました！"
      end

      it "無効な情報で登録を行うと登録失敗のフラッシュが表示されること" do
        fill_in "名前", with: ""
        fill_in "説明", with: "冬に行きたい、身体が温まるレストランです"
        click_button "登録する"
        expect(page).to have_content "名前を入力してください"
      end
    end
  end

  describe "レストラン詳細ページ" do
    context "ページレイアウト" do
      before do
        visit restaurant_path(restaurant)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{restaurant.name}")
      end

      it "レストラン情報が表示されること" do
        expect(page).to have_content restaurant.name
        expect(page).to have_content restaurant.description
      end
    end
  end
end
