class ItemImage < ApplicationRecord
  mount_uploader :image_URL, ItemImageUploader
  belongs_to :item, optional: true
end
