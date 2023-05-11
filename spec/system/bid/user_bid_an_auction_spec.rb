require 'rails_helper'

describe 'user bids an auction' do
  it 'sucessfully.' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

    new_auction.update(status: :running)
    login_as(new_user)
    visit root_path
    click_on "#{new_auction.auction_code}"
    within('div#bid') do
      fill_in "Offer", with: 10000
      click_on "Bid Auction"
    end

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The bid was made sucessfully."
    expect(page).to have_content "Current highest bid: 10000"
    expect(page).to have_content "Number of bids received: 1"
  end
end