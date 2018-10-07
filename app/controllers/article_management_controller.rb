class ArticleManagementController < ApplicationController

  def hide_article
    article_id = params[:article_id]
    user_id = current_user.id

  #   VALIDATE IF ARTICLE EXIST
    @article = NewsArticle.find_by(id: article_id)
    if !@article.present?
      raise Exception "article not found"
    end

    DeletedUserNewsArticle.find_or_create_by(user_id: user_id, news_article_id: article_id)
    redirect_back fallback_location: root_path

  end

end
