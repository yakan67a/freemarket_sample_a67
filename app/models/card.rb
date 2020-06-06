class Card < ApplicationRecord
  validates :customer_id, :user_id, presence: true
  belongs_to :user
  scope :pickup_parents, -> { where(ancestry: nil)}
end