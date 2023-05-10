require 'rails_helper'

describe 'admin tries to add a new item to an auction' do
  it 'sucessfully.' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                            zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
                        
    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#draft') do
      click_on 'bbc693221'
    end
    click_on "Add an item"
    fill_in "Name", with: "Ryzen 7 5800x"
    fill_in "Description", with: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture."
    fill_in "Weight", with: 247
    fill_in "Height", with: 3
    fill_in "Width", with: 8
    fill_in "Depth", with: 3
    select "technology", from: "Category"
    attach_file 'Photo', Rails.root.join("spec/support/images/ryzen7_5800.png")
    click_on "Save"

    expect(page).to have_content "The item was added sucessfully!"
    within('h2') do
      expect(page).to have_content "Item"
    end
    expect(page).to have_content "Name: Ryzen 7 5800x"
    expect(page).to have_content "Description: Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture."
    expect(page).to have_content "Dimensions: 3cm x 8cm x 3cm"
    expect(page).to have_content "Weight: 247g"
    expect(page).to have_content "Category: Technology"
    expect(page).to have_content "Item Code: #{new_auction.items.first.item_code}"
    expect(page).to have_css("img[src*='ryzen7_5800']")
  end
end
