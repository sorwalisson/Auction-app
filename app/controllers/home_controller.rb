class HomeController < ApplicationController
  before_action :authenticate_user_admin, only: [:admin_menu]
  def index
    @auctions = AuctionLot.all
  end

  def admin_menu
  end
end