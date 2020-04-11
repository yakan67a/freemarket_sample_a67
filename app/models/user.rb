class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :name_first, :name_last, :name_first_kana, :name_last_kana, :birth, presence: true
  validates :nickname, uniqueness: true
  has_one :shipping_address, dependent: :destroy
end
