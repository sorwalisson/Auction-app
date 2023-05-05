class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.text :description
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :depth
      t.string :image_url
      t.integer :category

      t.timestamps
    end
  end
end
