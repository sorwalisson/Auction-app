class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:admin_menu]
  before_action :authenticate_user_admin, only: [:admin_menu]

  def index
    @auctions = AuctionLot.all
  end

  def admin_menu
    @auctions = AuctionLot.all
  end

  def favorites
    @favorites = JSON.parse(current_user.favorites)
    @auctions = Array.new
    @favorites["auctions"].each {|auction| @auctions << AuctionLot.find_by(id: auction.to_i)}
  end
end