class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many   :comments
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :user  
  belongs_to :rating, dependent: :destroy
  has_one    :history

end
