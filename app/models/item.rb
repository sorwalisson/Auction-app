class Item < ApplicationRecord
  belongs_to :auction_lot
  validates :name, :description, :weight, :height, :width, :depth, :img_url, :category, :item_code, presence: true
  before_validation :set_code, on: :create


  def set_code
    self.item_code = SecureRandom.alphanumeric(10).upcase
  end
end
