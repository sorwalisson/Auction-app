require 'rails_helper'

describe 'user goes to auction an writes down a question' do
  it 'successfully' do
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
    click_on "bbc693221"
    fill_in "Question", with: "Is this product shipped to the entire country?"
    click_on "Send"

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The Question was added successfully!"
    within('div#questions') do
      expect(page).to have_content "Is this product shipped to the entire country?"
    end
    expect(new_auction.questions.count).to eq 1
  end

  it 'admins post an answer successfully' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3,
                                category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_question = Question.create!(message: "Is this product shipped to the entire country?", auction_lot_id: new_auction.id, user_id: new_user.id)
    new_auction.update(status: :running)

    login_as(new_admin)
    visit root_path
    click_on "bbc693221"
    within("div#answerq#{new_question.id}") do
      fill_in "Answer", with: "Yes, this product can be shipped all across the country."
      click_on "Send"
    end

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "Answer was posted successfully."
    within("div#answerq#{new_question.id}") do
      expect(page).to have_content "Yes, this product can be shipped all across the country."
      expect(page).to_not have_field "Answer"
    end
    expect(new_question.answer.present?).to eq true
  end

  it 'user go to auctions and sees that his question wasnt answered yet' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
            weight: 247, height: 3, width: 8, depth: 3,
            category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_question = Question.create!(message: "Is this product shipped to the entire country?", auction_lot_id: new_auction.id, user_id: new_user.id)
    new_auction.update(status: :running)

    login_as(new_user)
    visit root_path
    click_on "bbc693221"

    within("div#answerq#{new_question.id}") do
      expect(page).to have_content "There is not reply yet, wait till an admin answer your question!"
      expect(page).to_not have_field "Answer"
      expect(page).to_not have_button "Send"
    end
  end

  it 'user cannot make any question if not log_in' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
            weight: 247, height: 3, width: 8, depth: 3,
            category: 0, auction_lot_id: new_auction.id)
    new_auction.update(status: :running)

    visit root_path
    click_on "bbc693221"

    within('div#new_question') do
      expect(page).to have_content "Please, log in first before post a question!"
      expect(page).to_not have_field "Question"
      expect(page).to_not have_button "Send"
    end
  end

  it 'admin marks a question as not visible' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
      zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
            weight: 247, height: 3, width: 8, depth: 3,
            category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_question = Question.create!(message: "Is this product shipped to the entire country?", auction_lot_id: new_auction.id, user_id: new_user.id, visible: false)
    new_auction.update(status: :running)

    login_as(new_admin)
    visit root_path
    click_on "bbc693221"
    
    within('div#questions') do
      expect(page).to_not have_content "Is this product shipped to the entire country?"
      expect(page).to_not have_content "User: Stuart"
    end
  end

  it 'a question that is marked with visible: :false must not appear' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                            zip: "57000-100", cpf: "09814576492")
    new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, user_id: new_admin.id)
    new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                              weight: 247, height: 3, width: 8, depth: 3,
                              category: 0, auction_lot_id: new_auction.id)
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")
    new_question = Question.create!(message: "Is this product shipped to the entire country?", auction_lot_id: new_auction.id, user_id: new_user.id)
    new_auction.update(status: :running)
    
    login_as(new_admin)
    visit root_path
    click_on "bbc693221"
    within("div#question#{new_question.id}") do
      click_on "Mark this Question as invisible."
    end
    new_question.reload

    expect(current_path).to eq auction_lot_path(id: new_auction.id)
    expect(page).to have_content "The Question was marked as invisible!"
    expect(new_question.visible).to eq false
    expect(page).to_not have_content "Is this product shipped to the entire country?"
    expect(page).to_not have_content "User: Stuart"
  end
end