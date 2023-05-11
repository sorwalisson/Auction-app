require 'rails_helper'

describe 'User visits an auction and see it details' do
  it 'sucessfully.'
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "36454796000")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, 
                                     bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :confirmed)
    visit root_path
    click_on "#{new_auction.auction_code}"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "Lot Code: cxt890953"
    expect(page).to have_content "Starts At: #{5.hours.from_now}"
    expect(page).to have_content "Ends At: #{3.days.from_now}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_content "Bid Difference: 5%"
  end
end
