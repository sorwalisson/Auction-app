require 'rails_helper'


describe 'user log in with a suspended account' do
  it 'and sees message saying that his account is suspended' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@user.com", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    BlackListCpf.create(cpf: "09814576492")
    
    visit root_path
    click_on "Sign In"
    within('form#new_user') do
      fill_in 'Email', with: "sorwalisson@user.com"
      fill_in 'Password', with: "password"
      click_on "Log in"
    end

    expect(page).to have_content "This account is suspended check your email for more details."
  end

  it 'and tries to place a bid' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
          weight: 247, height: 3, width: 8, depth: 3,
          category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    BlackListCpf.create(cpf: "06516551022")

    new_auction.update(status: :running)
    login_as(new_user)
    visit root_path
    click_on "#{new_auction.auction_code}"
    within('div#bid') do
      fill_in "Offer", with: 10000
      click_on "Bid Auction"
    end

    expect(current_path).to eq root_path
    expect(page).to have_content "You cannot place bid, due to your account being suspended"
    expect(new_auction.bids.count).to eq 0
  end
end