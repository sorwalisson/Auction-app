require "rails_helper"

describe 'uses click on auction code on the home page and sees the auctions details' do
  it 'sucessfully' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                           weight: 247, height: 3, width: 8, depth: 3,
                           img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                           category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

    new_auction.update(status: :running)
    login_as(new_user)
    visit root_path
    click_on "bbc693221"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "Lot Code: bbc693221"
    expect(page).to have_content "Starts At: #{5.hours.from_now}"
    expect(page).to have_content "Ends At: #{3.days.from_now}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_content "Bid Difference: 5%"
    expect(page).to have_content "Status: running"
    expect(page).to have_link "Ryzen 7 5800x"
    expect(page).to have_link "Home Page"
    expect(page).to_not have_link "Admin Menu"
  end

  it 'user that is not an admin tries to see details of a draft auction' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                               category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

    login_as(new_user)
    visit auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end

  it 'user that is not an admin tries to see details of a awaiting confirmation auction' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                               category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    
    new_auction.update(status: :awaiting_confirmation)
    login_as(new_user)
    visit auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end
end