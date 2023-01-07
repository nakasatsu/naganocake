class Item < ApplicationRecord
  # 商品の画像をアップロードする
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage_500.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 200]).processed
  end

end
