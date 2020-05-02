class Card < ApplicationRecord
  validates :customer_id, :user_id, presence: true
  belongs_to :user
end