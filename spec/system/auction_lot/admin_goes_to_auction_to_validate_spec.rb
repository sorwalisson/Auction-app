describe 'rails_helper'


describe 'user goes to ended auction to validate' do
  it 'validates the auction sucessfully' do
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
    
    new_auction.update(status: :ended)

    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#ended') do
      click_on "#{new_auction.auction_code}"
    end
    click_on "Validate this auction"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The Auction was validated successfully!"
    expect(page).to have_content "Lot Code: bbc693221"
    expect(page).to have_content "Starts At: #{5.hours.from_now}"
    expect(page).to have_content "Ends At: #{3.days.from_now}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_content "Bid Difference: 5%"
    expect(page).to have_content "Status: validated"
    expect(page).to have_content "Number of bids received: 3"
    expect(page).to have_content "The winner offer was: 20000"
    expect(page).to have_content "The winner of this auction was: Tyrion"
  end

  it 'tries to validate but the auction does not meet criteria' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :ended)
    login_as(new_admin)
    visit root_path
    click_on 'Admin Menu'
    within('div#ended') do
      click_on "#{new_auction.auction_code}"
    end
    click_on "Validate this auction"

    expect(current_path).to eq root_path
    expect(page).to have_content "This auction does not meet criteria to be validated"
    expect(new_auction.status).to eq "ended"
  end

  it 'not admin user tries to access a auction with ended status and get redirect to root_path' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    first_user = User.create!(name: "Robert", email: "robert@baratheon.com.br", password: "password", address: "The Red Keep, Kings Landing", 
                              zip: "56000-000", cpf: "54753748057")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                               weight: 247, height: 3, width: 8, depth: 3,
                               category: 0, auction_lot_id: new_auction.id)
    
    new_auction.update(status: :ended)
    login_as(first_user)
    visit auction_lot_path(id: new_auction.id)

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end
end