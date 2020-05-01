class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :name_first, :name_last, :name_first_kana, :name_last_kana, :birth, presence: true
  validates :nickname, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, format: { with: /\A[a-z0-9]+\z/i }, on: :update, allow_blank: true
  validates :name_first, :name_last, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください" }
  validates :name_first_kana, :name_last_kana, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナで入力してください" }
  has_one :shipping_address, dependent: :destroy
end
