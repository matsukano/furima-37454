require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    order = FactoryBot.create(:order)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: order.user.id, item_id: order.item.id)
    sleep 0.1
  end

  describe "配送先登録" do
    context '配送先情報が登録できるとき' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品情報が登録できないとき' do
      it '郵便番号:必須' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号:「3桁ハイフン4桁」の半角文字列のみ保存可能' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号はハイフンを含んだ半角数字で入力してください")
      end
      it '都道府県:必須' do
        @order_shipping_address.prefecture_id = 0
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it '市区町村:必須' do
        @order_shipping_address.municipality = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地:必須' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号:必須' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号:半角数値のみ保存可能' do
        @order_shipping_address.phone_number = '０９０１２３４５６７８'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号は半角数字で入力してください")
      end
      it '電話番号:ハイフンを含むと保存不可' do
        @order_shipping_address.phone_number = '090-123-456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号はハイフンを含まず１０桁〜１１桁で入力してください")
      end
      it '電話番号:9桁以下では保存不可' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号はハイフンを含まず１０桁〜１１桁で入力してください")
      end
      it '電話番号:12桁以上では保存不可' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号はハイフンを含まず１０桁〜１１桁で入力してください")
      end
      it "token:必須" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it "item_id:必須" do
        @order_shipping_address.item_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end
      it "user_id:必須" do
        @order_shipping_address.user_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
