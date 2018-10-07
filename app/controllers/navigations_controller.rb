class NavigationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @deleted_articles_info = DeletedUserNewsArticle.where(user_id: current_user.id)
    deleted_article_ids = @deleted_articles_info.pluck(:news_article_id)
    @news_articles =  NewsArticle.where.not(id: deleted_article_ids )
                          .paginate(:page => params[:page], :per_page => 30)
                           .order('posted_on DESC')


  end
end
