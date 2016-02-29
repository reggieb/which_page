class CreateSourcePages < ActiveRecord::Migration
  def change
    create_table :source_pages do |t|
      t.string :url
      t.timestamps null: false
    end
  end
end
