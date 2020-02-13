class AddUrlToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :url, :text
  end
end
