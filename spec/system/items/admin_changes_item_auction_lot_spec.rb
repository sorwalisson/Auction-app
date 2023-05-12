require 'rails_helper'

describe 'admin tries to change auction_lot of an item' do
  it "succesfully" do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    old_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: old_auction.id)
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "yyc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)

    old_auction.update(status: :canceled)
    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#canceled') do
      click_on "#{old_auction.auction_code}"
    end
    select "yyc693221", from: "New Auction"
    click_on "Save"

    expect(current_path).to eq auction_lot_path(id: old_auction.id)
    expect(page).to_not have_link "Ryzen 7 5800x"
    expect(new_auction.items.count).to eq 1
    expect(new_auction.items.first.name).to eq "Ryzen 7 5800x"
  end
end