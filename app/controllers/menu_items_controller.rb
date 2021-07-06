class MenuItemsController < ApplicationController
  def index
  end

  def create
    # render plain: params[:menu_category_id]
    new_menuitem = MenuItem.new(
      menu_category_id: params[:menu_category_id],
      name: params[:name],
      description: params[:description],
      price: params[:price],
    )
    if new_menuitem.save
      redirect_to menu_categories_path
    else
      flash[:error] = new_menuitem.errors.full_messages.join(", ")
      redirect_to menu_categories_path
    end
  end

  def destroy
    id = params[:id]
    menu = MenuItem.find(id)
    menu.destroy
    redirect_to menu_categories_path
  end

  def update
    id = params[:id]
    menu = MenuItem.find(id)
    if params[:name].present?
      menu.update(name: params[:name])
    end
    if params[:description].present?
      menu.update(description: params[:description])
    end
    if params[:price].present?
      menu.update(price: params[:price])
    end

    redirect_to menu_categories_path
  end
end
