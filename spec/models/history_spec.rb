require 'rails_helper'

describe Card do
  describe "#create" do
    it "正しいuser_id, item_idがあれば登録できること" do
      
    end

    it "user_idがないと登録できないこと" do
      
    end

    it "存在しないuserのidがuser_idだと登録できないこと"do
      
    end
    
    it "user_idがitemの出品者のid(= item.user_id)だと登録できないこと" do
      
    end
    
    it "item_idがないと登録できないこと" do
      
    end

    it "存在しないitemのidがitem_idだと登録できないこと" do
      
    end
  end
end