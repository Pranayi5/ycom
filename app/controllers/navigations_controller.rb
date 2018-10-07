class NavigationsController < ApplicationController
  before_action :authenticate_user!
  PER_PAGE_SIZE = 30

  def index
    deleted_article_ids = DeletedUserNewsArticle.get_deleted_article_info_by_user(current_user.id)
    @news_articles =  NewsArticle.get_article_for_user_ordered_by_posted_on(deleted_article_ids, PER_PAGE_SIZE, params[:page])


  end
end
