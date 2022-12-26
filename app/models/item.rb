class Item < ApplicationRecord
  # 商品の画像をアップロードする
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre
end
