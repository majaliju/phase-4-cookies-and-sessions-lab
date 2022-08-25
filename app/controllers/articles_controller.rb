class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    byebug
    session[:page_views] ||= 0 

    byebug
    if sessions[:page_views] < 4
      sesions[:page_views] = session[:page_views] +1 
      byebug
      article = Article.find(params[:id])
      render json: article
   
   end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
