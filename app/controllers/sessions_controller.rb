# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_path, notice: '登录成功！'
    else
      flash.now[:alert] = '用户名或密码错误。'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: '您已成功退出。'
  end
end
