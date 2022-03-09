require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "購入情報登録" do
    before do
      @order = FactoryBot.create(:order)
      sleep 0.1
    end

    context '購入情報が登録できるとき' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@order).to be_valid
      end
    end
    context '購入情報が登録できないとき' do
      it "item_id:必須" do
        @order.item_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("商品情報を入力してください")
      end
      it "user_id:必須" do
        @order.user_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("購入者情報を入力してください")
      end
    end
  end
end
