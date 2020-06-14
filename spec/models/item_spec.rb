require 'rails_helper'
# require 'spec_helper'
describe Item do
  describe '#create' do


    it "商品名が空欄の場合は出品できないこと" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end
    it "商品の説明が空欄の場合は出品できないこと" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end
    it "価格が300円未満の場合は出品できないこと" do
      item = build(:item, price: "100")
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end
    it "価格が10000000円以上の場合は出品できないこと" do
      item = build(:item, price: "200000000")
      item.valid?
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end
    it "カテゴリーが未選択の場合は出品できないこと" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end
    it "商品の状態が未選択の場合は出品できないこと" do
      item = build(:item, status_id: "")
      item.valid?
      expect(item.errors[:status_id]).to include("can't be blank")
    end
    it "配送料の負担が未選択の場合は出品できないこと" do
      item = build(:item, cost_id: "")
      item.valid?
      expect(item.errors[:cost_id]).to include("can't be blank")
    end
    it "発送元の地域が未選択の場合は出品できないこと" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end
    it "発送までの日数が未選択の場合は出品できないこと" do
      item = build(:item, days_id: "")
      item.valid?
      expect(item.errors[:days_id]).to include("can't be blank")
    end
  end
end