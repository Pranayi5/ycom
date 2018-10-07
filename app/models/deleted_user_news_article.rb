class DeletedUserNewsArticle < ApplicationRecord
  belongs_to :news_article
  belongs_to :user

  def self.create_if_not_exist(user_id, article_id)
    find_or_create_by(user_id: user_id, news_article_id: article_id)
  end

  def self.get_deleted_article_info_by_user(user_id)
    deleted_articles_info = self.where(user_id: user_id)
    deleted_articles_info.pluck(:news_article_id)
  end

end
