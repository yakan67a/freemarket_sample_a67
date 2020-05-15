require 'rails_helper'

describe Card do
  describe "#create" do
    it "user_id, customer_id, card_idが存在すれば登録できること" do
      user = create(:user)
      card = build(:card, user_id: user.id)
      expect(card).to be_valid
    end

    it "user_idが存在しない場合登録できないこと" do
      card = build(:card, user_id: "")
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end

    it "存在しないユーザーのuser_idの場合登録できないこと" do
      user = create(:user)
      card = build(:card, user_id: user.id + 1)
      card.valid?
      expect(card.errors[:user]).to include("を入力してください")
    end

    it "customer_idがない場合登録できないこと" do
      user = create(:user)
      card = build(:card, user_id: user.id, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    
    it "card_idがない場合でも登録できること" do
      user = create(:user)
      card = build(:card, user_id: user.id, card_id: "")
      expect(card).to be_valid
    end
    
  end
end