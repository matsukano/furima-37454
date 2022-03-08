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
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号:「3桁ハイフン4桁」の半角文字列のみ保存可能' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県:必須' do
        @order_shipping_address.prefecture_id = 0
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村:必須' do
        @order_shipping_address.municipality = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地:必須' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号:必須' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号:10桁以上11桁以内の半角数値のみ保存可能' do
        @order_shipping_address.phone_number = '090-1234-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is not a number", "Phone number is out of setting range")
      end
      it '電話番号:9桁以下では保存不可' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is out of setting range")
      end
      it '電話番号:12桁以上では保存不可' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is out of setting range")
      end
      it "token:必須" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it "item_id:必須" do
        @order_shipping_address.item_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it "user_id:必須" do
        @order_shipping_address.user_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
