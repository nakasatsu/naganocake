class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # 注文ステータスの更新後、製作ステータスの更新を行う
    if @order.order_status == "confirmed"
      @order.order_details.each do |order_detail|
        order_detail.making_status = OrderDetail.making_statuses.key(1)
        order_detail.save
      end
    end
    redirect_to admin_order_path(@order.id)
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
