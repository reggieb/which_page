class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :text
      t.decimal :relevance, precision: 8, scale: 7
      t.string :sentiment
      t.references :source_page, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
