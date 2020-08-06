require "rails_helper"

RSpec.describe "レストラン編集", type: :request do
  let!(:admin_user) { create(:user, :admin) }
  let!(:restaurant) { create(:restaurant) }

  context "管理者ユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(admin_user)
      get edit_restaurant_path(restaurant)
      expect(response).to render_template('restaurants/edit')
      patch restaurant_path(restaurant), params: { restaurant: { name: "レストラン",
                                                                 description: "冬に行きたい、レストランです" } }
      redirect_to restaurant
      follow_redirect!
      expect(response).to render_template('restaurants/show')
    end
  end

  context "管理者ユーザーではない場合" do
    it "トップページにリダイレクトすること" do
      get edit_restaurant_path(restaurant)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      patch restaurant_path(restaurant), params: { restaurant: { name: "レストラン",
                                                                 description: "冬に行きたい、レストランです" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
