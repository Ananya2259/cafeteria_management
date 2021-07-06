class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in
  before_action :routes_manager

  def routes_manager
    if ["/edit_profile", "/main_menu"].include?(request.path) && current_user.role == "Admin"
      redirect_to root_path
    end
    if ["/users", "/menu_categories"].include?(request.path) && current_user.role == "user"
      redirect_to root_path
    end
    if ["/edit_profile", "/menu_categories"].include?(request.path) && current_user.role == "clerk"
      redirect_to root_path
    end
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def current_user #memoization
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
