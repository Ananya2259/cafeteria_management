class OrdersController < ApplicationController
  def index
    if params[:from].present? && params[:to].present?
      render "orders/index", locals: { from: params[:from], to: params[:to] }
    else
      render "orders/index", locals: { from: nil, to: nil }
    end
  end

  def create
    order = Order.new(user_id: session[:current_user_id], status: "pending", address: params[:address])
    order.save!
    redirect_to order_items_path(order_id: order.id)
  end

  def update
    order_id = params[:order_id]
    Order.find(order_id).update(status: "Delivered")
    redirect_to orders_index_path
  end

  def show
    render "show", locals: { id: params[:id] }
  end
end
