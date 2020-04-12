class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :name_first, :name_last, :name_first_kana, :name_last_kana, :zipcode, :prefecture_id, :city, :street_address, presence: true
  validates :name_first, :name_last, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください" }
  validates :name_first_kana, :name_last_kana, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナで入力してください" }
end