require "rails_helper"

RSpec.describe "レストランの削除", type: :request do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:restaurant) { create(:restaurant) }

  context "管理者ユーザーが削除する場合" do
    it "処理が成功し、トップページにリダイレクトすること" do
      login_for_request(admin_user)
      expect {
        delete restaurant_path(restaurant)
      }.to change(Restaurant, :count).by(-1)
      redirect_to root_path
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end
  end

  context "管理者ユーザーでない場合" do
    it "トップページへリダイレクトすること" do
      login_for_request(user)
      expect {
        delete restaurant_path(restaurant)
      }.not_to change(Restaurant, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
