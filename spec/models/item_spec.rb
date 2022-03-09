require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品登録" do
    context '商品情報が登録できるとき' do
      it 'image、item_name、item_description、item_category_id、item_condition_id、shipping_charge_id、prefecture_id、days_to_ship_id、price、user_idが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
      
    context '商品情報が登録できないとき' do
      it '商品画像(1枚):必須' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it '商品名:必須' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明:必須' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリー情報:必須' do
        @item.item_category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it '商品の状態:必須' do
        @item.item_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '配送料の負担:必須' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元の地域:必須' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it '発送までの日数:必須' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it '価格:必須' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '価格:300円未満では出品できない' do
        @item.price = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300〜¥9,999,999の範囲内で入力してください")
      end
      it '価格:9,999,999円を超えると出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300〜¥9,999,999の範囲内で入力してください")
      end
      it '価格:半角数値のみ保存可能' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300〜¥9,999,999の範囲内で入力してください", "価格は半角で入力してください")
      end
      it '出品者情報:必須' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品者情報を入力してください")
      end
    end
  end
end

