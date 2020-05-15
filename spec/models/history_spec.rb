require 'rails_helper'

describe History do
  before do
    category = create(:grand_category)
    exhibitor = create(:user)
    brand = create(:brand)
    category = create(:grand_category)
    @item = create(
      :item, 
      category_id: category.id, 
      user_id: exhibitor.id, 
      brand_id: brand.id
    )
    @user = create(:user)
  end
  describe "#create" do
    it "正しいuser_id, item_idがあれば登録できること" do
      history = build(:history, user_id: @user.id, item_id: @item.id)
      expect(history).to be_valid
    end

    it "user_idがないと登録できないこと" do
      history = build(:history, user_id: nil, item_id: @item.id)
      history.valid?
      expect(history.errors[:user]).to include("を入力してください")
    end

    it "存在しないuserのidがuser_idだと登録できないこと"do
    history = build(:history, user_id: 9999, item_id: @item.id)
    history.valid?
    expect(history.errors[:user]).to include("を入力してください")
      
    end

    it "item_idがないと登録できないこと" do
      history = build(:history, user_id: @user.id, item_id: nil)
      history.valid?
      expect(history.errors[:item]).to include("を入力してください")
    end

    it "存在しないitemのidがitem_idだと登録できないこと" do
      history = build(:history, user_id: @user.id, item_id: 9999)
      history.valid?
      expect(history.errors[:item]).to include("を入力してください")
    end
  end
end