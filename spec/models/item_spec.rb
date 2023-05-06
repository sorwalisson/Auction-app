require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it 'name must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)
     
      expect(new_product.valid?).to be_falsy
    end


    it 'Description must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)
     
      expect(new_product.valid?).to be_falsy
    end
   
    it 'weight must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: nil, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)
     
      expect(new_product.valid?).to be_falsy
    end
   
    it 'height must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: nil, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)


      expect(new_product.valid?).to be_falsy
    end


    it 'width must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: nil, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)


      expect(new_product.valid?).to be_falsy
    end


    it 'depth must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: nil,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology, auction_lot_id: new_auction.id)


      expect(new_product.valid?).to be_falsy
    end


    it 'image_url must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "",
                                category: :technology, auction_lot_id: new_auction.id)


      expect(new_product.valid?).to be_falsy
    end


    it 'status must be present' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: nil, auction_lot_id: new_auction.id)


      expect(new_product.valid?).to be_falsy
    end
  end

  describe 'item_code' do
    it 'when created a item_code must be set' do
      new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10)
      new_product = Item.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: 0, auction_lot_id: new_auction.id)
      new_product.save!
      
      expect(new_product.item_code.present?).to eq true
      expect(new_product.item_code.length).to eq 10
    end
  end
end
