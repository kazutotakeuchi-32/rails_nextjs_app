class Api::V1::Current::ArticlesController < Api::V1::BaseController
  before_action :authenticate_user!

  def index
    articles = current_user.articles
                           .not_status_unsaved
                           .includes(:user)
                           .order(created_at: :desc)
                           .page(params[:page] || 1)
                           .per(Article::PAGE_PER)

    render json: articles, meta: paginate(articles), adapter: :json
  end

  def show
    article = current_user.articles.find(params[:id])
    render json: article, serializer: CurrentArticleSerializer, adapter: :json
  end

  def create
    unsaved_article = current_user.articles.status_unsaved.first || current_user.articles.create(status: :unsaved)
    render json: unsaved_article, status: :created
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
    render json: article, status: :ok
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
