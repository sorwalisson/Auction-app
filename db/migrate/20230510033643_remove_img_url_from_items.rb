class RemoveImgUrlFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :img_url
  end
end
