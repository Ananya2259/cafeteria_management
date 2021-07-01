class CartItemsController < ApplicationController
  def create
    # render plain: params[:user_id]
    addtocart = CartItem.new(
      user_id: params[:user_id],
      menu_item_id: params[:menu_item_id],
      price: MenuItem.find(params[:menu_item_id]).price,
      quantity: 1,
    )
    if addtocart.save
      redirect_to main_menu_index_path
    else
      flash[:error] = addtocart.errors.full_messages.join(", ")
      redirect_to main_menu_index_path
    end
  end

  def update
    cart_item = CartItem.find_by(menu_item_id: params[:id])
    if params[:quantity] == "1"
      cart_item.quantity = cart_item.quantity + 1
      cart_item.save!
    else
      if !cart_item.nil?
        if cart_item.quantity > 1
          cart_item.quantity = cart_item.quantity - 1
          cart_item.save!
        else
          cart_item.destroy
        end
      end
    end
    redirect_to main_menu_index_path
  end
end
