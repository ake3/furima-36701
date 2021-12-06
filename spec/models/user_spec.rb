require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '入力に不備がなければ登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'last_nameが全角(漢字)であれば登録できる' do
        @user.last_name = '佐藤'
        expect(@user).to be_valid
      end
      it 'last_nameが全角(ひらがな)であれば登録できる' do
        @user.last_name = 'さとう'
        expect(@user).to be_valid
      end
      it 'last_nameが全角(カタカナ)であれば登録できる' do
        @user.last_name = 'サトウ'
        expect(@user).to be_valid
      end
      it 'first_nameが全角(漢字)であれば登録できる' do
        @user.first_name = '一郎'
        expect(@user).to be_valid
      end
      it 'first_nameが全角(ひらがな)であれば登録できる' do
        @user.first_name = 'いちろう'
        expect(@user).to be_valid
      end
      it 'first_nameが全角(カタカナ)であれば登録できる' do
        @user.first_name = 'イチロウ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角(カタカナ)であれば登録できる' do
        @user.last_name_kana = 'サトウ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角(カタカナ)であれば登録できる' do
        @user.first_name_kana = 'イチロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailが＠なしでは登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'cdf456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'ｲﾁﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaが全角(カタカナ)以外では登録できない' do
        @user.last_name_kana = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが全角(カタカナ)以外では登録できない' do
        @user.first_name_kana = 'いちろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
