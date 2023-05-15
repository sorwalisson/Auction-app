require 'rails_helper'

describe 'Users clicks on my_favorites' do
  it 'and sees his favorites auctions' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_auction.update(status: :running)
    new_user.add_favorite(new_auction.id)
    new_user.reload

    login_as(new_user)
    visit root_path
    click_on "My Favorites"
    
    expect(current_path).to eq my_favorites_path
    expect(page).to have_link "bbc693221"
    expect(page).to have_content "Starts At: #{new_auction.starting_time}"
    expect(page).to have_content "Ends At: #{new_auction.ending_time}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_link "Ryzen 7 5800x"
  end
end