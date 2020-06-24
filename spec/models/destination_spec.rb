require 'rails_helper'
describe Destination do
  describe '#create' do
    # presence: true
    it "名字が空欄の場合は登録できないこと" do
      destination = build(:destination, family_name: "")
      destination.valid?
      expect(destination.errors[:family_name]).to include("を入力してください")
    end
    it "氏名が空欄の場合は登録できないこと" do
      destination = build(:destination, first_name: "")
      destination.valid?
      expect(destination.errors[:first_name]).to include("を入力してください")
    end
    it "名字(カタカナ)が空欄の場合は登録できないこと" do
      destination = build(:destination, family_name_kana: "")
      destination.valid?
      expect(destination.errors[:family_name_kana]).to include("を入力してください")
    end
    it "氏名(カタカナ)が空欄の場合は登録できないこと" do
      destination = build(:destination, first_name_kana: "")
      destination.valid?
      expect(destination.errors[:first_name_kana]).to include("を入力してください")
    end
    it "郵便番号が空欄の場合は登録できないこと" do
      destination = build(:destination, post_code: "")
      destination.valid?
      expect(destination.errors[:post_code]).to include("を入力してください")
    end
    it "都道府県が空欄の場合は登録できないこと" do
      destination = build(:destination, prefecture_id: "")
      destination.valid?
      expect(destination.errors[:prefecture_id]).to include("を入力してください")
    end
    it "市町村が空欄の場合は登録できないこと" do
      destination = build(:destination, city: "")
      destination.valid?
      expect(destination.errors[:city]).to include("を入力してください")
    end
    it "その他住所が空欄の場合は登録できないこと" do
      destination = build(:destination, address: "")
      destination.valid?
      expect(destination.errors[:address]).to include("を入力してください")
    end
    # format: { with:/\A[ぁ-んァ-ン一-龥]/}
    it "名字が全角でない場合は登録できないこと" do
      destination = build(:destination, family_name: "test")
      destination.valid?
      expect(destination.errors[:family_name]).to include("は不正な値です")
    end
    it "氏名が全角でない場合は登録できないこと" do
      destination = build(:destination, first_name: "test")
      destination.valid?
      expect(destination.errors[:first_name]).to include("は不正な値です")
    end
    # format: { with: /\A[ァ-ヶー－]+\z/}
    it "名字(カタカナ)が全角カタカナでない場合は登録できないこと" do
      destination = build(:destination, family_name_kana: "田中")
      destination.valid?
      expect(destination.errors[:family_name_kana]).to include("は不正な値です")
    end
    it "氏名(カタカナ)が全角カタカナでない場合は登録できないこと" do
      destination = build(:destination, first_name_kana: "太郎")
      destination.valid?
      expect(destination.errors[:first_name_kana]).to include("は不正な値です")
    end
    # format: { with: /\A\d{7}\z/ } 
    it "郵便番号が8桁以上の場合は登録できないこと" do
      destination = build(:destination, post_code: "00000000")
      destination.valid?
      expect(destination.errors[:post_code]).to include("は不正な値です")
    end
    it "郵便番号が6桁以下の場合は登録できないこと" do
      destination = build(:destination, post_code: "000000")
      destination.valid?
      expect(destination.errors[:post_code]).to include("は不正な値です")
    end
    # format: { with: /\A[0-9]+\z/}
    it "電話番号が半角数字でない場合は登録できないこと" do
      destination = build(:destination, phone_number: "電話番号")
      destination.valid?
      expect(destination.errors[:phone_number]).to include("は不正な値です")
    end   
  end
end
