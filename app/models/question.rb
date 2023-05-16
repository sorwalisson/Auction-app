class Question < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot
  has_one :answer
  validates :message, presence: true
end
