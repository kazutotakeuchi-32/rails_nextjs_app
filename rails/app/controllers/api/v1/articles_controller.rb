# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < Api::V1::BaseController
      def index
        articles = Article.
                     published.
                     includes(:user).
                     order(created_at: :desc).
                     page(params[:page] || 1).
                     per(Article::PAGE_PER)
        render json: articles, meta: paginate(articles), adapter: :json
      rescue => e
        render json: { errors: e.message }, status: :internal_server_error
      end

      def show
        article = Article.status_published.find(params[:id])
        render json: article
      end
    end
  end
end
