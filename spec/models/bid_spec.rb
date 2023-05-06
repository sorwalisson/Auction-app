require 'rails_helper'

RSpec.describe Bid, type: :model do
  context "validations" do
    it 'offer must be present' do
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                          address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :started)
      new_bid = Bid.new(offer: nil, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to be false
    end

    it 'when its the first bid, it should be >= than the auction.starting_bid' do
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :started)
      new_bid = Bid.new(offer: 500, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to be false
    end

    it 'when there are already bids made, the new bid must be auction_lot.bid_difference % higher' do
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      second_user = User.create!(name: "Daniel", password: "password", email: "daniel@email.com", address: "Rua Santo, 35", zip: "57071-130", cpf: "11011343649")
      third_user = User.create!(name: "Zoraide", password: "password", email: "zoraide@email.com", address: "Rua Santo, 30", zip: "57071-130", cpf: "12123671975")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :started)
      existing_bid_one = Bid.create!(offer: 2000, auction_lot_id: new_auction.id, user_id: new_user.id)
      existing_bid_two = Bid.create!(offer: 7000, auction_lot_id: new_auction.id, user_id: third_user.id)
      new_bid = Bid.new(offer: 2150, auction_lot_id: new_auction.id, user_id: second_user.id)


      expect(new_bid.valid?).to be false
      expect(new_bid.errors[:offer]).to include("should be higher than 7700")
    end
  end
end
