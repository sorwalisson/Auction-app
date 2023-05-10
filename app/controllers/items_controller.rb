class ItemsController < ApplicationController
  
  def show
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    @item = Item.find_by(id: params[:id])
  end
  
  def new
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    @item = Item.new()
  end

  def create
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    @item = Item.new(item_params)
    @item.auction_lot_id = @auction_lot.id
    if @item.save
      redirect_to [@auction_lot, @item], notice: t('status_msg.item.item_saved')
    else
      flash.now[:notice] = t('status.item.item_not_saved')
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :weight, :height, :width, :depth, :category, :photo)
  end
end