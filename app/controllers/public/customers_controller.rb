class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find_by(id: current_user.id)
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

end
