require 'rails_helper'

describe Item do
  before do
    @category = create(:grand_category)
    @user = create(:user)
    @brand = create(:brand)
    # TODO: comment_idのテスト
  end
  describe '#create' do
    it "items_name, item_description, price, shipping_area_id, condition, category_id, days_to_ship, shipping_costs, user_id, brand_idがあれば登録できる" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id
      )
      expect(item).to be_valid
    end

    it "items_nameが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        items_name: nil
      )
      item.valid?
      expect(item.errors[:items_name]).to include("を入力してください")
    end

    it "item_descriptionが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        item_description: nil
      )
      item.valid?
      expect(item.errors[:item_description]).to include("を入力してください")
    end

    it "priceが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        price: nil
      )
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "user_idが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: nil, 
        brand_id: @brand.id
      )
      item.valid?
      expect(item.errors[:user]).to include("を入力してください")
    end

    it "brand_idがなくても登録ができる" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: nil
      )
      expect(item).to be_valid
    end

    it "shipping_area_idが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        shipping_area_id: nil
      )
      item.valid?
      expect(item.errors[:shipping_area_id]).to include("を入力してください")
    end

    it "conditionが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        condition: nil
      )
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "category_idが空ならNG" do
      item = build(
        :item, 
        category_id: nil, 
        user_id: @user.id, 
        brand_id: @brand.id
      )
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "days_to_shipが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        days_to_ship: nil
      )
      item.valid?
      expect(item.errors[:days_to_ship]).to include("を入力してください")
    end
    
    it "shipping_costsが空ならNG" do
      item = build(
        :item, 
        category_id: @category.id, 
        user_id: @user.id, 
        brand_id: @brand.id, 
        shipping_costs: nil
      )
      item.valid?
      expect(item.errors[:shipping_costs]).to include("を入力してください")
    end
  end
end
