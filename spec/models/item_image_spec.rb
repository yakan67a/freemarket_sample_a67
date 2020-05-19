describe ItemImage do
  describe "#create" do
    it "image_URLが空ならNG" do
      item_image = build(:item_image, image_URL: nil)
      item_image.valid?
      expect(item_image.errors[:image_URL]).to include("を入力してください")
    end
    it "image_URLがあるなら登録できる" do
      item_image = build(:item_image)
      item_image.valid?
      expect(item_image).to be_valid
    end
  end
end