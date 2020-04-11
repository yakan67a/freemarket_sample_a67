class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :name_first, :name_last, :name_first_kana, :name_last_kana, :zipcode, :city, :street_address, presence: true
end