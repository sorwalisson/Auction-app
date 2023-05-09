require 'rails_helper'

describe 'admin tries to edit an auction' do
  it 'sucessfully' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                              category: 0, auction_lot_id: new_auction.id)
    
    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#draft') do
      click_on 'bbc693221'
    end
    click_on "Edit Auction"
    fill_in "Ends At", with: 5.days.from_now
    fill_in "Starting Bid", with: 4000
    click_on 'Save'

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "Auction was updated sucessfully."
    expect(page).to have_content "Ends At: #{5.days.from_now}"
    expect(page).to have_content "Starting Bid: 4000"
  end

  it 'admin tries to edit a auction that is a confirmed auction and fails' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :confirmed)
    login_as(new_admin)
    visit edit_auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end

  it 'admin tries to edit a auction that is a running auction and fails' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
            weight: 247, height: 3, width: 8, depth: 3,
            img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
            category: 0, auction_lot_id: new_auction.id)

    new_auction.update(status: :running)
    login_as(new_admin)
    visit edit_auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end
  
  it 'admins tries to edit an auction that is ended and fails' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
          weight: 247, height: 3, width: 8, depth: 3,
          img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
          category: 0, auction_lot_id: new_auction.id)

    new_auction.update(status: :ended)
    login_as(new_admin)
    visit edit_auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end

  it 'regular user tries to acess edit page' do
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
          weight: 247, height: 3, width: 8, depth: 3,
          img_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
          category: 0, auction_lot_id: new_auction.id)

    new_auction.update(status: :ended)
    login_as(new_user)
    visit edit_auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end
end