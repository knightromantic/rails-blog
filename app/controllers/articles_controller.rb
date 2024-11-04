class ArticlesController < ApplicationController
  include Pundit
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_article, only: [:edit, :update, :destroy]

  # 列出所有文章
  def index
    @articles = Article.all
    authorize @articles
  end

  # 显示单个文章
  def show
    authorize @article
  end

  # 创建新文章的表单
  def new
    @article = Article.new
    authorize @article
  end

  # 创建新文章
  def create
    @article = current_user.articles.build(article_params)
    authorize @article

    if @article.save
      redirect_to @article, notice: '文章创建成功。'
    else
      render :new
    end
  end

  # 编辑文章的表单
  def edit
  end

  # 更新文章
  def update
    if @article.update(article_params)
      redirect_to @article, notice: '文章更新成功。'
    else
      render :edit
    end
  end

  # 删除文章
  def destroy
    @article.destroy
    redirect_to articles_path, notice: '文章删除成功。'
  end

  private

  # 设置当前文章
  def set_article
    @article = Article.find(params[:id])
  end

  # 授权当前文章
  def authorize_article
    authorize @article
  end

  # 强参数：仅允许特定参数
  def article_params
    params.require(:article).permit(:title, :content) # 根据实际需要调整
  end
end
