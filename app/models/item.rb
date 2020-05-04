class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many   :comments
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :user  
  has_one    :rating, dependent: :destroy
  has_one    :history

  validates :items_name, :item_description, :condition, :shipping_costs, :days_to_ship, :price, :category_id, :shipping_area_id, presence: true
  validates :items_name, length: {maximum: 40}
  validates :price, inclusion: { in: 300..9999999 }

end
