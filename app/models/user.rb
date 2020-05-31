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

  mount_uploader :profile_image, MypageImageUploader
  has_many :histories
  has_one :card, dependent: :destroy
  has_many :items

  # has_many :items, through: :historiesとしてしまうと自分の出品商品一覧が取得できなくなるため、
  # 別途自分が購入した商品を取得するメソッドの定義を行う。
  def bought_item
    item_ids = []
    self.histories.each do |history|
      item_ids << history.item_id
    end
    Item.includes(:item_images).find(item_ids)
  end
end
