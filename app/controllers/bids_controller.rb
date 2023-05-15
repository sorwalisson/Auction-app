class BidsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :check_requirements, only: [:create]
  def create
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])

    @bid = Bid.new(offer: params[:offer])
    @bid.user_id = current_user.id
    @bid.auction_lot_id = @auction_lot.id

    if @bid.save
      redirect_to @auction_lot, notice: t('status_msg.bid.bid_saved')
    else
      redirect_to @auction_lot, notice: t('status_msg.bid.bid_not_saved')
    end
  end


  private

  def check_requirements
    if current_user.admin? then redirect_to root_path, notice: t('status_msg.bid.if_admin') end
    if current_user.cpf_checker == true then redirect_to root_path, notice: t('status_msg.bid.if_suspended') end
  end
end