class OrdersController < ApplicationController
  def index
  end

  def create
    order = Order.new(user_id: session[:current_user_id], status: "pending", address: params[:address])
    order.save!
    redirect_to order_items_path(order_id: order.id)
  end
end
