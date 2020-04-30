class Item < ApplicationRecord
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many   :comments
  belongs_to :category
  belongs_to :brand
  belongs_to :prefecture
  belongs_to :user
  belongs_to :rating, dependent: :destroy
end
