class AddressesController < ApplicationController
  def create
    if params[:address].present?
      address = params[:address]
      user_address = Address.new(address: address, user_id: session[:current_user_id])
      if user_address.save
        redirect_to orders_path(address: address)
      else
        flash[:error] = user_address.errors.full_messages.join(", ")
        redirect_to main_menu_index_path
      end
    else
      address = @current_user.addresses.last.address
      redirect_to orders_path(address: address)
    end
  end
end
