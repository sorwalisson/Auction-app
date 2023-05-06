class AuctionLot < ApplicationRecord
  enum status: {draft: 0, awaiting_confirmation: 1, confirmed: 2, started: 3, ended: 4}
  validates :starting_time, :ending_time, :auction_code, :starting_bid, :bid_difference, presence: true
  validates :auction_code, uniqueness: true
  validate :code_validation


  def code_validation
    numbers = ("0".."9").to_a
    letters = ("a".."z").to_a
    count_n = 0
    count_l = 0 
    if self.auction_code.length != 9
      self.errors.add(:auction_code, "must have 9 characters, 3 of them must be letters")
      return
    end

    if self.auction_code.split(//).map do |element|
      if numbers.include?(element) == false and letters.include?(element) == false
        self.errors.add(:auction_code, "Must be only lowercase letters and numbers")
        return
      end
      if numbers.include?(element) then count_n += 1 end
      if letters.include?(element) then count_l += 1 end
    end
    if count_n != 6 and count_l != 3 then self.errors.add(:auction_code, "Must have 3 lower case letters and 6 numbers") end
    end
  end
end
