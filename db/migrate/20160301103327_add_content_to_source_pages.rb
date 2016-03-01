class AddContentToSourcePages < ActiveRecord::Migration
  def change
    add_column :source_pages, :content, :text
  end
end
