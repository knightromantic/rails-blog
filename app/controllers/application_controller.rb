class ApplicationController < ActionController::Base
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
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: '文章创建成功。'
    else
      render :new
    end
  end

  # 编辑文章的表单
  def edit
    @article = Article.find(params[:id])
  end

  # 更新文章
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: '文章更新成功。'
    else
      render :edit
    end
  end

  # 删除文章
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: '文章删除成功。'
  end

  private

  # 强参数：仅允许特定参数
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
