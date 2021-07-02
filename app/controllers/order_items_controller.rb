class OrderItemsController < ApplicationController
  def create
    @current_user.cart_items.all.each do |cart_items|
      menu_detail = cart_items.menu_item
      OrderItem.create!(
        order_id: params[:order_id],
        menu_item_name: menu_detail.name,
        menu_item_id: menu_detail.id,
        price: menu_detail.price,
        quantity: cart_items.quantity,
      )
    end
    @current_user.cart_items.destroy_all
    redirect_to main_menu_index_path
  end
end
