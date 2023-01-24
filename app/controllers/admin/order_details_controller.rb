class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    is_updated = true
    @order_detail.update(order_detail_params)
    @order.update(order_status: 2) if @order_detail.making_status_i18n == "製作中"
      # if @order_detail.making_status_i18n == "製作中"
        ### @order.update(order_status: 2)
        # @order.order_status = Order.order_statuses.key(2)
        # @order.save
      # end
      @order_details.each do |order_detail|
        is_updated = false if order_detail.making_status_i18n != "製作完了"
        # if order_detail.making_status_i18n != "製作完了"
          # is_update = false
        # end
      end
      @order.update(order_status: 3) if is_updated
      # if is_update == true
        # @order.order_status = Order.order_statuses.key(3)
        # @order.save
      # end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
