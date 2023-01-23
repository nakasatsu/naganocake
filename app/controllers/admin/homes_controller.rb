class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).order(created_at: :desc)
    @total_amount = 0
  end

end
