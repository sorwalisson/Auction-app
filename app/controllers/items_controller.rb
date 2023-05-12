class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :change_auction]
  before_action :authenticate_user_admin, only: [:new, :create, :change_auction]
  
  def show
    @item = Item.find_by(id: params[:id])
  end
  
  def new
    verify_draft
    @item = Item.new()
  end

  def create
    verify_draft
    @item = Item.new(item_params)
    @item.auction_lot_id = @auction_lot.id
    if @item.save
      redirect_to [@auction_lot, @item], notice: t('status_msg.item.item_saved')
    else
      flash.now[:notice] = t('status.item.item_not_saved')
    end
  end

  def change_auction
    verify_canceled
    @item = Item.find_by(id: params[:id])
    if AuctionLot.find_by(id: params[:new_lot_id]).status == "draft"
      @item.update(auction_lot_id: params[:new_lot_id])
      redirect_to @auction_lot, notice: t('status_msg.item.item_moved')
      return
    else
      redirect_to root_path, notice: t("status_msg.item.auction_not_canceled")
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :weight, :height, :width, :depth, :category, :photo)
  end

  def verify_draft
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    if @auction_lot.status != "draft" then redirect_to root_path, notice: t("status_msg.item.auction_not_draft") end
    @auction_lot
  end

  def verify_canceled
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    if @auction_lot.status != "canceled" then redirect_to root_path, notice: t("status_msg.item.auction_not_canceled") and return end
    @auction_lot
  end

end