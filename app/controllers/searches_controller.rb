require 'pry'
class SearchesController < ApplicationController
  
  def show
    @result = SearchesQuery.new(params: params[:query]).call
    if @result.is_a?(AuctionLot) then redirect_to auction_lot_path(id: @result.id) end
    if @result.is_a?(Item) then redirect_to auction_lot_item_path(auction_lot_id: @result.auction_lot_id, id: @result.id) end
  end
end