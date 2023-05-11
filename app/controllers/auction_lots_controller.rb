class AuctionLotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :awaiting_confirmation, :confirmed]
  before_action :authenticate_user_admin, only: [:new, :create, :edit, :update, :awaiting_confirmation, :confirmed]
  def show
    set_lot_and_verify
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

  def edit
    set_lot_for_update
  end

  def update
    set_lot_for_update

    if @auction_lot.update(auction_lot_params)
      redirect_to @auction_lot, notice: t('status_msg.general.updated_successfully')
    else
      flash.now[:notice] = t('update_failed')
      render 'edit'
    end
  end

  def awaiting_confirmation
    set_lot_for_update
    @auction_lot.update(status: :awaiting_confirmation)
    redirect_to @auction_lot, notice: t('status_msg.auction.set_awaiting')
  end

  def confirmed
    set_for_confirmed
    if current_user.id == @auction_lot.user_id
      redirect_to @auction_lot, notice: t('status_msg.auction.not_set_confirmed')
    else 
      @auction_lot.update(status: :confirmed)
      redirect_to @auction_lot, notice: t('status_msg.auction.set_confirmed')
    end
  end

  private
  def auction_lot_params
    params.require(:auction_lot).permit(:auction_code, :starting_time, :ending_time, :starting_bid, :bid_difference)
  end

  def set_lot_and_verify
    @auction_lot = AuctionLot.find_by(id: params[:id])
    if @auction_lot.status != "running" and @auction_lot.status != "ended" and @auction_lot.status != "confirmed" then authenticate_user_admin end
    @auction_lot
  end

  def set_lot_for_update
    @auction_lot = AuctionLot.find_by(id: params[:id])
    if @auction_lot.status != "draft" then redirect_to root_path, notice: t('status_msg.auction.acess_denied') end
    @auction_lot
  end

  def set_for_confirmed
    @auction_lot = AuctionLot.find_by(id: params[:id])
    if @auction_lot.status != "awaiting_confirmation" then redirect_to root_path, notice: t('status_msg.auction.acess_denied') end
    @auction_lot
  end
end