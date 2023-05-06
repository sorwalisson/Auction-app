class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :depth
      t.string :img_url
      t.integer :category
      t.string :item_code
      t.references :auction_lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
