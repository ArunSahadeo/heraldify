class AddAuthorFieldToArticles < ActiveRecord::Migration[5.2]
  def up
      add_column :articles, :author, :string
  end

  def down
      remove_column :articles, :author 
  end
end
