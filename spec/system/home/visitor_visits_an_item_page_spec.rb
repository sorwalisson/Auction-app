require 'rails_helper'


describe 'visitor visits an item page' do
  it 'sucessfully' do
    new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@leilaodogalpao.com.br', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
    new_auction = AuctionLot.create!(starting_time: 1.day.from_now, ending_time: 2.days.from_now, auction_code: "bbc693221", starting_bid: 1000, bid_difference: 10, user_id: new_user.id)
    file = Rails.root.join("spec/support/images/ryzen7_5800.png")
    image = ActiveStorage::Blob.create_and_upload!(
      io: File.open(file, 'rb'),
      filename: 'ryzen7_5800.png',
      content_type: 'image/png'
      ).signed_id
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id, photo: image)
    
    new_auction.update(status: :confirmed)
    visit root_path
    click_on "#{new_auction.auction_code}"
    click_on "Ryzen 7 5800x"

    expect(current_path).to eq auction_lot_item_path(auction_lot_id: new_auction.id, id: new_product.id)
    expect(page).to have_content "Name: Ryzen 7 5800x"
    expect(page).to have_content "Description: Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture."
    expect(page).to have_content "Dimensions: 3cm x 8cm x 3cm"
    expect(page).to have_content "Weight: 247g"
    expect(page).to have_content "Category: Technology"
    expect(page).to have_content "Item Code: #{new_product.item_code}"
    expect(page).to have_css("img[src*='ryzen7_5800']")
  end
end