require 'pry'
class SearchesQuery
  
  def initialize(params)
    @params = params[:params]
  end

  def call
    if @params.length == 9
      result = search_auctions
      if result.is_a?(AuctionLot)
        if ["confirmed", "running", "validated"].include?(result.status) == false then return nil end
      end
      return result unless result == nil
    end
    if @params.length == 10
      result = search_item_by_code
      if result.is_a?(Item)
        if ["confirmed", "running", "validated"].include?(result.auction_lot.status) == false then return nil end
      end
      return result unless result == nil
    end
    return search_item_by_name
  end



  def search_auctions
    AuctionLot.find_by(auction_code: @params)
  end

  def search_item_by_code
    Item.find_by(item_code: @params)
  end

  def search_item_by_name
    @items = Item.where("name LIKE ?", "%#{@params}%")
    if @items.count == 1 then return @items.first end
    @items
  end
end