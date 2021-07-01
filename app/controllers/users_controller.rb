class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if User.any?
      render "users/new", :locals => { role: "user" }
    else
      render "users/new", :locals => { role: "Admin" }
    end
  end

  # def index
  #   render plain: User.all.map { |user| user.to_user_details }.join("\n")
  # end

  def create
    user = User.new(
      name: params[:name],
      role: params[:role],
      email: params[:email],
      password: params[:password],
    )
    if user.save
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      redirect_to new_user_path
      flash[:error] = user.errors.full_messages.join(", ")
    end
  end
end
