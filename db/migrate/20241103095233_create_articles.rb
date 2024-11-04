# db/migrate/xxxxxx_create_articles.rb
class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
