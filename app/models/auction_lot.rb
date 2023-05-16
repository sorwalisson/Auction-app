class AuctionLot < ApplicationRecord
  enum status: {draft: 0, awaiting_confirmation: 1, confirmed: 2, running: 3, ended: 4, validated: 5, canceled: 6}
  validates :starting_time, :ending_time, :auction_code, :starting_bid, :bid_difference, presence: true
  validates :auction_code, uniqueness: true
  validate :code_validation
  has_many :items
  has_many :bids
  has_many :questions
  belongs_to :user


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

  def highest_bid
    if self.bids.count > 0 then self.bids.order("offer DESC").first.offer end
  end

  def new_bid_value
    x = self.highest_bid * self.bid_difference / 100
    highest_bid + x
  end

  def highest_bid_user
    if self.bids.count > 0
      self.bids.order("offer DESC").first.user_id
    end
  end
  
  def status_updater
    if self.status == "draft" 
      self.update(status: :awaiting_confirmation) 
      self.save
      return
    end
    if self.status == "awaiting_confirmation"
      StatusChangerJob.perform_at(self.starting_time, self.id)
      self.update(status: :confirmed)
      self.save
      return
    end
    if self.status == "confirmed"
      StatusChangerJob.perform_at(self.ending_time, self.id)
      self.update(status: :running)
      self.save
      return
    end
    if self.status == "running" 
      self.update(status: :ended) 
    end
  end
end
