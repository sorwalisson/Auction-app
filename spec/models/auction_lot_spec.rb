require 'rails_helper'

RSpec.describe AuctionLot, type: :model do
  describe 'Auction_lot validations' do
    it 'start date must be present' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: nil, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'ending date must be present' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: nil, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'auction_code must be present' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'auction_code must be valid code, return not valid when length is less than 9.' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc22321", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'auction_code must be valid code, return not valid when there is special characters' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc69322&", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'auction_code must be valid code, return not valid when there are more than three letters' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc69322c", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.valid?).to be false
    end

    it 'must be unique' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      second_auction = AuctionLot.new(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)
      

      expect(second_auction.valid?).to be false
    end
  end

  describe 'status' do
    it 'after criation, status must be :draft' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_admin.id)

      expect(new_auction.status).to eq "draft"
    end
  end
end
