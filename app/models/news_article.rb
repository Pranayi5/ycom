class NewsArticle < ApplicationRecord
  has_many :deleted_user_news_articles

  def self.get_article_for_user_ordered_by_posted_on(hidden_article_id, page_size, page_no)

    self.where.not(id: hidden_article_id )
        .paginate(:page => page_no, :per_page => page_size)
        .order('posted_on DESC')
  end
end
