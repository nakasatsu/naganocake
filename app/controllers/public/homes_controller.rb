class Public::HomesController < ApplicationController
  def top
    # 最新の商品を降順に表示
    @items = Item.order(created_at: :desc).first(4)
  end

  def about
  end

end
