class MenuCategoriesController < ApplicationController
  def index
    render "index"
  end

  def create
    name = params[:name]
    new_menu_categories = MenuCategory.new(name: name)
    if new_menu_categories.save
      redirect_to menu_categories_path
    else
      flash[:error] = new_menu_categories.errors.full_messages.join(", ")
      redirect_to menu_categories_path
    end
  end

  def destroy
    id = params[:id]
    MenuItem.where(menu_category_id: id).destroy_all
    MenuCategory.find(id).destroy
    redirect_to menu_categories_path
  end

  def update
    id = params[:id]
    menu = MenuCategory.find(id)
    if params[:status].present?
      if params[:status] == "active"
        menu.update(status: "inactive")
      else
        menu.update(status: "active")
      end
    else
      menu.update(name: params[:name])
    end
    redirect_to menu_categories_path
  end
end
