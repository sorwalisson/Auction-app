class Item < ApplicationRecord
  belongs_to :auction_lot
  enum category: {technology: 0, furniture: 1, tools: 2, appliances: 3, cars: 4, car_parts: 5, toys: 6, sports: 7}
  validates :name, :description, :weight, :height, :width, :depth, :category, :item_code, presence: true
  before_validation :set_code, on: :create
  has_one_attached :photo


  def set_code
    self.item_code = SecureRandom.alphanumeric(10).upcase
  end

  def dimensions
    "#{self.height}cm x #{self.width}cm x #{self.depth}cm"
  end
end
