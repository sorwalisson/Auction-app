class WonAuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @auctions = AuctionLot.all.where(status: :validated)
    @won_auctions = Array.new
    @auctions.each {|auction| if auction.highest_bid_user == current_user.id then @won_auctions << auction end}
  end
end