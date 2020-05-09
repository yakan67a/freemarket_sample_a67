require 'rails_helper'

describe Item do
  describe '#create' do
    
    it "nameが空ならNG" do
      item = build(:item, items_name: nil)
      item.valid?
      expect(item.errors[:items_name]).to include("を入力してください")
    end
    it "descriptionが空ならNG" do
      item = build(:item, item_description: nil)
      item.valid?
      expect(item.errors[:item_description]).to include("を入力してください")
    end
    it "priceが空ならNG" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end
    it "prefectureが空ならNG" do
      item = build(:item, shipping_area_id: nil)
      item.valid?
      expect(item.errors[:shipping_area_id]).to include("を入力してください")
    end
    it "conditionが空ならNG" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end
    it "categoryが空ならNG" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end
    it "days_to_shipが空ならNG" do
      item = build(:item, days_to_ship: nil)
      item.valid?
      expect(item.errors[:days_to_ship]).to include("を入力してください")
    end
    it "shipping_costsが空ならNG" do
      item = build(:item, shipping_costs: nil)
      item.valid?
      expect(item.errors[:shipping_costs]).to include("を入力してください")
    end
    it "priceがinteger以外ならNG" do
      item = build(:item, price: "３００")
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end
    it "priceが300円未満ならNG" do
      item = build(:item, price: "290")
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end
    it "priceが9999999円よりも高額ならNG" do
      item = build(:item, price: "19999999")
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値にしてください")
    end
  end
end
