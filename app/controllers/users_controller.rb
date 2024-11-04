class UsersController < ApplicationController
  def new
    @user = User.new  # 创建一个新的用户实例
  end

  def create
    @user = User.new(user_params)  # 使用安全参数创建用户
    if @user.save
      session[:user_id] = @user.id  # 自动登录
      redirect_to articles_path, notice: '注册成功！'
    else
      render :new  # 如果保存失败，重新渲染注册表单
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)  # 确保只允许这些参数
  end
end
