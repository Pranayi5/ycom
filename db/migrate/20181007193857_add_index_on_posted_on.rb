class AddIndexOnPostedOn < ActiveRecord::Migration[5.1]
  def change
    add_index(:news_articles, :posted_on, name: 'posted_on_id')
  end
end
