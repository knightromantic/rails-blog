class SessionsController < ApplicationController
  def new
    # 显示登录表单
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) # 假设你已经在 User 模型中设置了密码
      session[:user_id] = user.id # 将用户 ID 存储到 session
      redirect_to articles_path, notice: '登录成功！'
    else
      flash.now[:alert] = '邮箱或密码无效。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil # 清除 session
    redirect_to root_path, notice: '成功登出。'
  end
end
