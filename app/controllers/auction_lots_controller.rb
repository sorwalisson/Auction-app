class AuctionLotsController < ApplicationController
  
  def show
    @auction_lot = AuctionLot.find_by(id: params[:id])
  end
  
  def new
    @auction_lot = AuctionLot.new()
  end

  def create
    @auction_lot = AuctionLot.new(auction_lot_params)
    @auction_lot.user_id = current_user.id

    if @auction_lot.save
      redirect_to @auction_lot, notice: t("status_msg.auction.created")
    else
      flash.now[:notice] = t('status_msg.auction.creation_failed')
      render 'new'
    end
  end







  private
  def auction_lot_params
    params.require(:auction_lot).permit(:auction_code, :starting_time, :ending_time, :starting_bid, :bid_difference)
  end
end