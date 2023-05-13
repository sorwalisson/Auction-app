require 'rails_helper'

describe 'User clicks on Won Auction' do
  it 'and see auction that he had won' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    first_user = User.create!(name: "Robert", email: "robert@baratheon.com.br", password: "password", address: "The Red Keep, Kings Landing", zip: "56000-000", cpf: "54753748057")
    second_user = User.create!(name: "Ned", email: "ned@stark.com.br", password: "password", address: "Winterfell Castle", zip: "55000-000", cpf: "41694258041")
    third_user = User.create!(name: "Tyrion", email: "tyrion@lannister.com.br", password: "password", address: "The Red keep, Kings Landing", zip: "56000-000", cpf: "01353041050")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
          weight: 247, height: 3, width: 8, depth: 3,
          category: 0, auction_lot_id: new_auction.id)
    new_auction.update(status: :running)
    first_bid = Bid.create!(offer: 6000, user_id: first_user.id, auction_lot_id: new_auction.id)
    second_bid = Bid.create!(offer: 12000, user_id: second_user.id, auction_lot_id: new_auction.id)
    third_bid = Bid.create!(offer: 20000, user_id: third_user.id, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :validated)
    login_as(third_user)
    visit root_path
    click_on 'Won Auctions'

    expect(page).to have_content "Won Auctions"
    expect(page).to have_link "#{new_auction.auction_code}"
    expect(page).to have_content "Offer Value: #{new_auction.highest_bid}"
    expect(page).to have_content "Acquired Items:"
    expect(page).to have_link "Ryzen 7 5800x"
  end

  it 'if the user did not won a auction it should display a msg' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                            zip: "57000-100", cpf: "09814576492")
    first_user = User.create!(name: "Robert", email: "robert@baratheon.com.br", password: "password", address: "The Red Keep, Kings Landing", zip: "56000-000", cpf: "54753748057")
    second_user = User.create!(name: "Ned", email: "ned@stark.com.br", password: "password", address: "Winterfell Castle", zip: "55000-000", cpf: "41694258041")
    third_user = User.create!(name: "Tyrion", email: "tyrion@lannister.com.br", password: "password", address: "The Red keep, Kings Landing", zip: "56000-000", cpf: "01353041050")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)
    new_auction.update(status: :running)
    first_bid = Bid.create!(offer: 6000, user_id: first_user.id, auction_lot_id: new_auction.id)
    second_bid = Bid.create!(offer: 12000, user_id: second_user.id, auction_lot_id: new_auction.id)
    third_bid = Bid.create!(offer: 20000, user_id: third_user.id, auction_lot_id: new_auction.id)

    new_auction.update(status: :validated)
    login_as(second_user)
    visit root_path
    click_on 'Won Auctions'

    expect(page).to have_content "You did not won any auctions yet!"
  end

  it 'visitor tries to access won auctions, and is redirect to login page' do
    visit won_auctions_path

    expect(current_path).to eq new_user_session_path
  end
end