require 'rails_helper'

describe ShippingAddress do
  describe '#create' do
    it "name_last、name_first、name_last_kana、name_first_kana、zipcode、prefecture_id、city、street_address が存在すれば登録できること" do
      shipping_address = build(:shipping_address)
      expect(shipping_address).to be_valid
    end

    # 名前
    it "name_lastがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_last: "")
      shipping_address.valid?
      expect(shipping_address.errors[:name_last]).to include("can't be blank")
    end

    it "name_firstがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_first: "")
      shipping_address.valid?
      expect(shipping_address.errors[:name_first]).to include("can't be blank")
    end

    # 名前カナ
    it "name_last_kanaがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_last_kana: "")
      shipping_address.valid?
      expect(shipping_address.errors[:name_last_kana]).to include("can't be blank")
    end

    it "name_last_kanaが全角カタカナの場合は登録できること" do
      shipping_address = build(:shipping_address, name_last_kana: "タナカ")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end

    it "name_last_kanaが全角カタカナでない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_last_kana: "tanaka")
      shipping_address.valid?
      expect(shipping_address.errors[:name_last_kana]).to include("全角カタカナで入力してください")
    end

    it "name_first_kanaがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_first_kana: "")
      shipping_address.valid?
      expect(shipping_address.errors[:name_first_kana]).to include("can't be blank")
    end

    it "name_last_kanaが全角カタカナの場合は登録できること" do
      shipping_address = build(:shipping_address, name_first_kana: "タロウ")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end

    it "name_last_kanaが全角カタカナでない場合は登録できないこと" do
      shipping_address = build(:shipping_address, name_first_kana: "taro")
      shipping_address.valid?
      expect(shipping_address.errors[:name_first_kana]).to include("全角カタカナで入力してください")
    end

     # 郵便番号
    it "zipcodeがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, zipcode: "")
      shipping_address.valid?
      expect(shipping_address.errors[:zipcode]).to include("can't be blank")
    end

     # 都道府県ID
    it "prefecture_idがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, prefecture_id: "")
      shipping_address.valid?
      expect(shipping_address.errors[:prefecture_id]).to include("can't be blank")
    end

    # 市区町村
    it "cityがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, city: "")
      shipping_address.valid?
      expect(shipping_address.errors[:city]).to include("can't be blank")
    end

    # その他、番地
    it "street_addressがない場合は登録できないこと" do
      shipping_address = build(:shipping_address, street_address: "")
      shipping_address.valid?
      expect(shipping_address.errors[:street_address]).to include("can't be blank")
    end

    # ビル部屋
    it "buildingが空白な場合でも登録できること" do
      shipping_address = build(:shipping_address, building: "")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end
    it "buildingが入力されていても登録できること" do
      shipping_address = build(:shipping_address, building: "KIITEビルディング")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end

    # 電話番号
    it "phone_numberが空白な場合でも登録できること" do
      shipping_address = build(:shipping_address, phone_number: "")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end
    it "phone_numberが入力されていても登録できること" do
      shipping_address = build(:shipping_address, phone_number: "09012341234")
      shipping_address.valid?
      expect(shipping_address).to be_valid
    end
    
  end
end