class CreateNewsArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :news_articles do |t|
      t.integer :ycom_item_id, unique: true
      t.string :title, :null => false
      t.string :external_url, :null => false
      t.string :ycom_url, :null => false
      t.integer :comments_count, :default => 0, :null => false
      t.string :votes_count, :default => 0, :null => false
      t.datetime :posted_on

      t.timestamps
    end
    #add_index :created_at
  end
end
