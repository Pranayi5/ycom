class CreateDeletedUserNewsArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :deleted_user_news_articles do |t|
      t.integer :user_id, :null => false
      t.string :news_article_id, :null => false

      t.timestamps
    end
  end
end
