# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def user_not_authorized
    flash[:alert] = "您没有权限执行此操作。"
    redirect_to(request.referrer || root_path)
  end
end
