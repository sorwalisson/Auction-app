class AddUserToAuctionLot < ActiveRecord::Migration[7.0]
  def change
    add_reference :auction_lots, :user, null: false, foreign_key: true
  end
end
