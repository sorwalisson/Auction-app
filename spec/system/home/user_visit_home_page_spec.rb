require 'rails_helper'

describe 'user visit home page' do
  it 'and see the name of the site and see title' do
    visit root_path

    expect(page).to have_link("Go Auction!")
    expect(page).to have_content("Where you buy your dreams")
    expect(page).to have_content('Welcome to Go Auction, Dreams on a bid distance!')
  end

  it 'and sees current running auctions' do
    new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@leilaodogalpao.com.br', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
    new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_user.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :running)
    visit root_path

    expect(page).to have_content "Running Auctions"
    expect(page).to have_link "#{new_auction.auction_code}"
    expect(page).to have_content "Ends At: #{new_auction.ending_time}"
    expect(page).to have_content "Current highest bid: No one bid this lot yet"
    expect(page).to have_content "Items:"
    expect(page).to have_link "Ryzen 7 5800x"
  end

  it "and sees upcoming auctions" do
    new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@leilaodogalpao.com.br', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
    new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_user.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :confirmed)
    visit root_path

    expect(page).to have_content "Upcoming Auctions"
    expect(page).to have_content "Lot Code:"
    expect(page).to have_link "#{new_auction.auction_code}"
    expect(page).to have_content "Starts At: #{new_auction.starting_time}"
    expect(page).to have_content "Ends At: #{new_auction.ending_time}"
    expect(page).to have_content "Starting Bid: #{new_auction.starting_bid}"
    expect(page).to have_content "Items:"
    expect(page).to have_link "Ryzen 7 5800x"
  end
end