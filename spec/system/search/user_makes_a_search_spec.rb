require 'rails_helper'

describe 'user uses the search' do
  context 'and tries to find an auction' do
    it 'and finds it' do
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
      fill_in 'Search', with: "#{new_auction.auction_code}"
      click_on 'Search'

      expect(current_path).to eq auction_lot_path(id: new_auction.id)
    end

    it 'and doesnt find it because the auction is different from confirmed/running/validated' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                              zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                  weight: 247, height: 3, width: 8, depth: 3,
                                  category: 0, auction_lot_id: new_auction.id)
      new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

      login_as(new_user)
      visit root_path
      fill_in 'Search', with: "#{new_auction.auction_code}"
      click_on 'Search'

      expect(page).to have_content "No results found"
    end
  end

  context 'and tries to find an item' do
    it 'with item_code and finds it' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
        zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
      file = Rails.root.join("spec/support/images/ryzen7_5800.png")
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(file, 'rb'),
        filename: 'ryzen7_5800.png',
        content_type: 'image/png'
        ).signed_id
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                weight: 247, height: 3, width: 8, depth: 3,
                category: 0, auction_lot_id: new_auction.id, photo: image)
      new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
      new_auction.update(status: :running)

      login_as(new_user)
      visit root_path
      fill_in 'Search', with: "#{new_product.item_code}"
      click_on 'Search'

      expect(current_path).to eq auction_lot_item_path(auction_lot_id: new_auction.id, id: new_product.id)
    end

    it 'with item name when there is one result possible' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
        zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
      file = Rails.root.join("spec/support/images/ryzen7_5800.png")
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(file, 'rb'),
        filename: 'ryzen7_5800.png',
        content_type: 'image/png'
        ).signed_id
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                weight: 247, height: 3, width: 8, depth: 3,
                category: 0, auction_lot_id: new_auction.id, photo: image)
      new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
      new_auction.update(status: :running)

      login_as(new_user)
      visit root_path
      fill_in 'Search', with: "Ryzen"
      click_on 'Search'

      expect(current_path).to eq auction_lot_item_path(auction_lot_id: new_auction.id, id: new_product.id)
    end

    it 'with item name where there is more than one result possible' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
        zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
      file = Rails.root.join("spec/support/images/ryzen7_5800.png")
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(file, 'rb'),
        filename: 'ryzen7_5800.png',
        content_type: 'image/png'
        ).signed_id
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                weight: 247, height: 3, width: 8, depth: 3,
                category: 0, auction_lot_id: new_auction.id, photo: image)
      second_product = Item.create!(name: "Ryzen 5 5600x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                    weight: 247, height: 3, width: 8, depth: 3,
                                    category: 0, auction_lot_id: new_auction.id)
      new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
      new_auction.update(status: :running)

      login_as(new_user)
      visit root_path
      fill_in 'Search', with: "Ryzen"
      click_on 'Search'

      expect(current_path).to eq search_path
      expect(page).to have_content "Number of items found: 2"
      expect(page).to have_link "Ryzen 7 5800x"
      expect(page).to have_link "bbc693221"
      expect(page).to have_link "Ryzen 5 5600x"
    end

    it 'tries to find an item of an auction that is not confirmed nor running nor validated' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                              zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                  weight: 247, height: 3, width: 8, depth: 3,
                                  category: 0, auction_lot_id: new_auction.id)
      new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

      login_as(new_user)
      visit root_path
      fill_in 'Search', with: "#{new_auction.auction_code}"
      click_on 'Search'

      expect(page).to have_content "No results found"
    end
  end
end

