class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.shipping_cost = 800
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @order.shipping_cost = 800
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order = Order.new(order_params)
      @order.shipping_cost = 800
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # if @order.payment_method == "credit_card"
      # @order.payment_method = Order.payment_methods[:credit_card]
    # elsif @order.payment_method == "transfer"
      # @order.payment_method = Order.paymentmethods[:transfer]
    # end
    @order.save
    
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.item.with_tax_price
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
  end

  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  end
end
