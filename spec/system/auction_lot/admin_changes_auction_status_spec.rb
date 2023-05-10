require 'rails_helper'


describe 'admin changes status of a auction' do
  it 'admin changes status from draft to awaiting confirmation' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)

    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#draft') do
      click_on 'bbc693221'
    end
    click_on "Change status to awaiting confirmation"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The auction is now set as awaiting confirmation"
    expect(page).to have_content "Status: awaiting_confirmation"
    expect(page).to_not have_button "Change status to awaiting confirmation"
    expect(page).to have_button "Change status to confirmed"
  end

  it 'admin changes status to confirmed, a admin that is different from the one who created the auction' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                            zip: "57000-100", cpf: "09814576492")
    second_admin  = User.create!(name: "stuart", email: "stuart@leilaodogalpao.com.br", password: "password", address: "Avenida Getulio Vargas, 50", 
                                zip: "50000-500", cpf: "22542452016")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :awaiting_confirmation)
    login_as(second_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#awaiting_confirmation') do
      click_on 'bbc693221'
    end
    click_on "Change status to confirmed"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The auction was set as confirmed"
    expect(page).to have_content "Status: confirmed"
    expect(page).to_not have_button "Change status to confirmed"
  end

  it 'admin tries to change status to confirmed, but it fails because its the same admin who created the auction' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
                             
    new_auction.update(status: :awaiting_confirmation)
    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#awaiting_confirmation') do
      click_on 'bbc693221'
    end
    click_on "Change status to confirmed"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "Could not change status to confirmed, because the admin is the same as the creater of the auction."
    expect(page).to have_content "Status: awaiting_confirmation"
    expect(page).to have_button "Change status to confirmed"
  end
end