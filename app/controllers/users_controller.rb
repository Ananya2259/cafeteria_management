class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, except: [:index, :edit_profile]

  def new
    if User.any?
      render "users/new", :locals => { role: "user" }
    else
      render "users/new", :locals => { role: "Admin" }
    end
  end

  def index
    render "user_display"
  end

  def add_user
    render "add_new_users", :locals => { role: params[:role] }
  end

  def create
    user = User.new(
      name: params[:name],
      role: params[:role],
      email: params[:email],
      password: params[:password],
    )
    if user.save
      if params[:created_by_admin] == "true"
        Address.create!(address: params[:address], user_id: user.id)
        redirect_to users_path
      else
        session[:current_user_id] = user.id
        redirect_to "/"
      end
    else
      redirect_to new_user_path
      flash[:error] = user.errors.full_messages.join(", ")
    end
  end

  def destroy
    CartItem.where(user_id: params[:user_id]).destroy_all
    User.find(params[:user_id]).destroy
    redirect_to users_path
  end

  def edit_user
    render "edit_user", :locals => { user_id: params[:user_id] }
  end

  def update_user
    id = params[:user_id]
    user = User.find(id)
    if params[:name].present?
      user.update(name: params[:name])
    end
    if params[:email].present?
      user.update(email: params[:email])
    end
    if params[:address].present?
      address = Address.find_by(user_id: params[:user_id])
      address.update(address: params[:address])
    end

    redirect_to users_path
  end

  def edit_profile
    render "edit_profile"
  end

  def update_profile
    user = User.find(session[:current_user_id])
    address = Address.where(user_id: user.id).last
    success = ""
    if user && user.authenticate(params[:password])
      if params[:name].present?
        user.update(name: params[:name])
        success = "Your attempt was sucessfull."
      end
      if params[:email].present?
        user.update(email: params[:email])
        success = "Your attempt was sucessfull."
      end
      if params[:address].present?
        address.update(address: params[:address])
        success = "Your attempt was sucessfull."
      end
    end

    if user.authenticate(params[:password])
      user.update(password: params[:new_password])
      success = "Your attempt was sucessfull."
    else
      flash[:error] = "Invalid password"
    end
    if success != ""
      flash[:success] = success
    end
    redirect_back(fallback_location: main_menu_index_path)
  end
end
