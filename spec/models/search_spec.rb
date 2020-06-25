require 'rails_helper'

  describe '#search' do
    context 'searchで求めるものを返す場合' do
      it 'nameがあれば表示される' do
        expect(build(:item, name: nil)).to be_valid
      end
    end
    context 'searchで全て返す場合' do
      it 'nameがなければ全て表示される' do
        name = build(:item, name: nil)
        name.valid?
        expect(name.errors[:content]).to include("を入力してください")
      end
    end
  end


