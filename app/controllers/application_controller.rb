class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end


class ArticlesController < ApplicationController
  # 列出所有文章
  def index
    @articles = Article.all
  end

  # 显示单个文章
  def show
    @article = Article.find(params[:id])
  end

  # 创建新文章的表单
  def new
    @article = Article.new
  end

  # 创建新文章
  def create
    @article = current_user.articles.build(article_params)  # 关联当前用户
    if @article.save
      redirect_to @article, notice: '文章创建成功。'
    else
      render :new
    end
  end

  # 编辑文章的表单
  def edit
    @article = Article.find(params[:id])
    authorize_user!  # 验证权限
  end

  # 更新文章
  def update
    @article = Article.find(params[:id])
    authorize_user!  # 验证权限
    if @article.update(article_params)
      redirect_to @article, notice: '文章更新成功。'
    else
      render :edit
    end
  end

  # 删除文章
  def destroy
    @article = Article.find(params[:id])
    authorize_user!  # 验证权限
    @article.destroy
    redirect_to articles_path, notice: '文章删除成功。'
  end

  private

  # 强参数：仅允许特定参数
  def article_params
    params.require(:article).permit(:title, :body)
  end

  # 自定义方法，确保当前用户是文章的作者
  def authorize_user!
    unless @article.user == current_user
      redirect_to articles_path, alert: '您没有权限进行此操作。'
    end
  end
end
