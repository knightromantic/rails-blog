# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
    authorize @articles
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = current_user.articles.build(article_params)
    authorize @article

    if @article.save
      redirect_to @article, notice: '文章创建成功。'
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article
  end

  def update
    @article = Article.find(params[:id])
    authorize @article

    if @article.update(article_params)
      redirect_to @article, notice: '文章更新成功。'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy
    redirect_to articles_path, notice: '文章删除成功。'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
