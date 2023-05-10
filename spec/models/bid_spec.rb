require 'rails_helper'

RSpec.describe Bid, type: :model do
  context "validations" do
    it 'offer must be present' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                          address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :running)
      new_bid = Bid.new(offer: nil, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to be false
    end

    it 'when its the first bid, it should be >= than the auction.starting_bid' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :running)
      new_bid = Bid.new(offer: 500, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to be false
    end

    it 'when there are already bids made, the new bid must be auction_lot.bid_difference % higher' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      second_user = User.create!(name: "Daniel", password: "password", email: "daniel@email.com", address: "Rua Santo, 35", zip: "57071-130", cpf: "11011343649")
      third_user = User.create!(name: "Zoraide", password: "password", email: "zoraide@email.com", address: "Rua Santo, 30", zip: "57071-130", cpf: "12123671975")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: new_auction.id)
      
      new_auction.update(status: :running)
      existing_bid_one = Bid.create!(offer: 2000, auction_lot_id: new_auction.id, user_id: new_user.id)
      existing_bid_two = Bid.create!(offer: 7000, auction_lot_id: new_auction.id, user_id: third_user.id)
      new_bid = Bid.new(offer: 2150, auction_lot_id: new_auction.id, user_id: second_user.id)


      expect(new_bid.valid?).to be false
      expect(new_bid.errors[:offer]).to include("should be higher than 7700")
    end

    it 'validate that admins cannot place a bid' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@leilaodogalpao.com.br', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: new_auction.id)
      new_auction.update(status: :running)
      new_bid = Bid.new(offer: 2500, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to be false
      expect(new_bid.errors[:user_id]).to include("User Admin cannot place bids")
    end

    context "validate bids on auction status" do
      it "Bids cannot be placed on auction that are on draft" do
        new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                                 zip: "57000-100", cpf: "09814576492")
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com.br', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
        new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                  weight: 247, height: 3, width: 8, depth: 3,
                                  category: 0, auction_lot_id: new_auction.id)
        new_bid = Bid.new(offer: 2500, auction_lot_id: new_auction.id, user_id: new_user.id)

        expect(new_bid.valid?).to be false
        expect(new_bid.errors[:auction_id]).to include("The auction must be running")
      end

      it "Bids cannot be placed on auction that are on confirmed" do
        new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                                 zip: "57000-100", cpf: "09814576492")
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com.br', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
        new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                  weight: 247, height: 3, width: 8, depth: 3,
                                  category: 0, auction_lot_id: new_auction.id)
        new_bid = Bid.new(offer: 2500, auction_lot_id: new_auction.id, user_id: new_user.id)
        
        new_auction.update(status: :confirmed)
        
        expect(new_bid.valid?).to be false
        expect(new_bid.errors[:auction_id]).to include("The auction must be running")
      end

      it "Bids cannot be placed on auction that are on confirmed" do
        new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                                 zip: "57000-100", cpf: "09814576492")
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com.br', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
        new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                  weight: 247, height: 3, width: 8, depth: 3,
                                  category: 0, auction_lot_id: new_auction.id)
        new_bid = Bid.new(offer: 2500, auction_lot_id: new_auction.id, user_id: new_user.id)
        
        new_auction.update(status: :ended)
        
        expect(new_bid.valid?).to be false
        expect(new_bid.errors[:auction_id]).to include("The auction must be running")
      end
    end
    it 'User cannot bid again if he holds the highest bid' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                              address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                weight: 247, height: 3, width: 8, depth: 3,
                category: 0, auction_lot_id: new_auction.id)

      new_auction.update(status: :running)
      bid_one = Bid.create!(offer: 2000, auction_lot_id: new_auction.id, user_id: new_user.id)
      bid_two = Bid.new(offer: 7000, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(bid_two.valid?).to be false
      expect(bid_two.errors[:user_id]).to include("You already hold the highest bid")
    end

    it 'User must be able to bid again, if he is not the current highest bid' do
      new_admin = User.create!(name: "Daniel", email: "daniel@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 30",
                               zip: "57000-100", cpf: "09814576492")
      new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
        address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
      second_user = User.create!(name: "Daniel", password: "password", email: "daniel@email.com", address: "Rua Santo, 35", zip: "57071-130", cpf: "11011343649")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      new_product = Item.create(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                weight: 247, height: 3, width: 8, depth: 3,
                category: 0, auction_lot_id: new_auction.id)

      new_auction.update(status: :running)
      existing_bid_one = Bid.create!(offer: 2000, auction_lot_id: new_auction.id, user_id: new_user.id)
      existing_bid_two = Bid.create!(offer: 7000, auction_lot_id: new_auction.id, user_id: second_user.id)
      new_bid = Bid.new(offer: 10000, auction_lot_id: new_auction.id, user_id: new_user.id)

      expect(new_bid.valid?).to eq true
    end
  end
end
