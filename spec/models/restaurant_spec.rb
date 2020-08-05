require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let!(:restaurant) { create(:restaurant) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(restaurant).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      restaurant = build(:restaurant, name: nil)
      restaurant.valid?
      expect(restaurant.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      restaurant = build(:restaurant, name: "あ" * 31)
      restaurant.valid?
      expect(restaurant.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      restaurant = build(:restaurant, description: "あ" * 141)
      restaurant.valid?
      expect(restaurant.errors[:description]).to include("は140文字以内で入力してください")
    end
  end
end
