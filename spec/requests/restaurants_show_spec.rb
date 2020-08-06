require "rails_helper"

RSpec.describe "レストラン個別ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:restaurant) { create(:restaurant) }

  it "レスポンスが正常に表示されること" do
    get restaurant_path(restaurant)
    expect(response).to have_http_status "200"
    expect(response).to render_template('restaurants/show')
  end
end
