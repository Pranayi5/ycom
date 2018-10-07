class ArticleManagementController < ApplicationController

  def hide_article
    article_id = params[:article_id]
    user_id = current_user.id

    validate_if_exists?(article_id)

    DeletedUserNewsArticle.create_if_not_exist(user_id, article_id)
    redirect_back fallback_location: root_path

  end


  private

  def validate_if_exists?(article_id)
    @article = NewsArticle.find_by(id: article_id)
    if !@article.present?
      raise Exception "article not found"
    end
  end

end
