class Category < ApplicationRecord
  has_many :items
  has_ancestry

  scope :pickup_parents, -> { where(ancestry: nil)}
  scope :childrenTree, -> (categoryPerChild){ where(ancestry: categoryPerChild) }

  


end
