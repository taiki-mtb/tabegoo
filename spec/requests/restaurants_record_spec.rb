require "rails_helper"

RSpec.describe "レストラン登録", type: :request do
  let!(:admin_user)  { create(:user, :admin) }
  let!(:user)        { create(:user) }
  let!(:restaurant)  { create(:restaurant) }
  let!(:category)    { create(:category) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_restaurant.jpg') }
  let(:picture)      { Rack::Test::UploadedFile.new(picture_path) }

  context "管理者ユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(admin_user)
      get new_restaurant_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('restaurants/new')
    end

    it "無効なデータでは登録できないこと" do
      expect {
        post restaurants_path, params: { restaurant: { name: "",
                                                       description: "オススメのレストランです",
                                                       images: picture } }
      }.not_to change(Restaurant, :count)
      expect(response).to render_template('restaurants/new')
    end
  end

  context "管理者以外のユーザーの場合" do
    it "トップページへリダイレクトすること" do
      login_for_request(user)
      get new_restaurant_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
