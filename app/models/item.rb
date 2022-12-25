class Item < ApplicationRecord
  # 商品の画像をアップロードする
  has_one_attached :image
end
