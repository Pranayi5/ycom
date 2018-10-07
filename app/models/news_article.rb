class NewsArticle < ApplicationRecord
  has_many :deleted_user_news_articles
end
