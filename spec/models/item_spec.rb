require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が登録できる場合' do
      it '入力に不備がなければ登録できる' do
        expect(@item).to be_valid
      end
      it 'selling_priceが半角数字かつ300~9999999の範囲内であれば登録できる' do
        @item.selling_price = '300'
        expect(@item).to be_valid
      end
    end
    context '商品が登録できない場合' do
      it 'imageが空では登録できない' do
        @item.image = nil 
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'explanationが空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'category_idが1(---)では登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが1(---)では登録できない' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'shipping_cost_idが1(---)では登録できない' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")  
      end
      it 'prefecture_idが1(---)では登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'shipping_date_idが1(---)では登録できない' do
        @item.shipping_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it 'selling_priceが空では登録できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it 'selling_priceが全角では登録できない' do
        @item.selling_price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is invalid. Input half-width characters")
      end
      it 'selling_priceが数字以外では登録できない' do
        @item.selling_price = '三百'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is invalid. Input half-width characters")
      end
      it 'selling_priceが299以下では登録できない' do
        @item.selling_price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is out of setting range")
      end
      it 'selling_priceが10000000以上では登録できない' do
        @item.selling_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is out of setting range")
      end
      it 'ユーザーが紐づいてなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end