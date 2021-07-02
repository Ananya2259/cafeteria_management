class AddressesController < ApplicationController
  def create
    if params[:address]
      address = params[:address]
      user_address = Address.create!(address: address, user_id: session[:current_user_id])
      user_address.save!
      redirect_to orders_path(address: address)
    else
      address = @current_user.addresses.last
      redirect_to orders_path(address: address)
    end
  end
end
