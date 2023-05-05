class ProductModel < ApplicationRecord
  enum category: {technology: 0, furniture: 1, cars: 2, books: 3}
  validates :name, :description, :weight, :height, :width, :depth, :image_url, :category, presence: true
end
