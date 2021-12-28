require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:user)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '購入情報が保存できる場合' do
      it '入力に不備がなければ保存できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
      it 'postal_codeが3桁ハイフン4桁の半角文字列であれば保存できる' do
        @order_shipping_address.postal_code = '123-1234'
        expect(@order_shipping_address).to be_valid
      end
      it 'phone_numberが10桁以上11桁以内の半角数値であれば保存できる' do
        @order_shipping_address.phone_number = '09012345678'
        expect(@order_shipping_address).to be_valid
      end
    end
    context '購入情報が保存できない場合' do
      it 'postal_codeが空では保存できない' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'postal_codeが3桁ハイフン4桁の形式でなければ保存できない' do
        @order_shipping_address.postal_code = '1231234'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'postal_codeが全角では保存できない' do
        @order_shipping_address.postal_code = '１２３ー１２３４'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'cityが空では保存できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空では保存できない' do
        @order_shipping_address.addresses = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空では保存できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角では保存できない' do
        @order_shipping_address.phone_number = '０９０１２３４５６７８'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Enter it as follows (e.g. 09012345678)")
      end
      it 'phone_numberが数値以外では保存できない' do
        @order_shipping_address.phone_number = '090-1234-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Enter it as follows (e.g. 09012345678)")
      end
      it 'phone_numberが10桁以上11桁以内でなければ保存できない' do
        @order_shipping_address.phone_number = '0901234'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Enter it as follows (e.g. 09012345678)")
      end
      it 'prefecture_idが1(---)では保存できない' do
        @order_shipping_address.prefecture_id = '1'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'ユーザーが紐づいてなければ保存できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐づいてなければ保存できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
