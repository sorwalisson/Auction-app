class CreateAuctionLots < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_lots do |t|
      t.datetime :starting_time
      t.datetime :ending_time
      t.string :auction_code
      t.integer :status, default: 0
      t.integer :starting_bid
      t.integer :bid_difference

      t.timestamps
    end
  end
end
