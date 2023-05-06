require 'pry'
class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot
  validates :offer, presence: true
  validate :start_bid_validation

  def start_bid_validation
    if self.offer.nil? 
      self.errors.add(:offer, "must have a value!")
      return 
    end
    if self.user.admin?
      self.errors.add(:offer, "must not be made by an admin!")
      return
    end
    bid_auction_validation()
  end
  
  def bid_auction_validation
    if self.auction_lot.bids.count == 0
      if self.offer < self.auction_lot.starting_bid then self.errors.add(:offer, "should be higher than the initial bid") end
    else
      if self.offer < self.auction_lot.new_bid_value then self.errors.add(:offer, "should be higher than #{self.auction_lot.new_bid_value}") end
    end
  end
end
