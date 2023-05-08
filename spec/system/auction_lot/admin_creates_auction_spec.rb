require 'rails_helper'

describe 'Admin goes to create auction through admin menu' do
  it 'and creates auction succesfully' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    
    login_as(new_admin)                         
    visit root_path
    click_on "Admin Menu"
    click_on "Create a new auction"
    fill_in "Lot Code", with: "cxt890953"
    fill_in "Starts At", with: 5.hours.from_now
    fill_in "Ends At", with: 3.days.from_now
    fill_in "Starting Bid", with: 5000
    fill_in "Bid Difference", with: 5
    click_on "Save"


    expect(page).to have_content "The new auction was created sucessfully!"
    expect(page).to have_content "Lot Code: cxt890953"
    expect(page).to have_content "Starts At: #{5.hours.from_now}"
    expect(page).to have_content "Ends At: #{3.days.from_now}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_content "Bid Difference: 5%"
    expect(page).to have_content "Status: draft"
    expect(page).to have_content "Created by: Walisson - sorwalisson@leilaodogalpao.com.br"
  end

  it 'users that is not an admin tries to create a new auction' do
    new_user = User.create!(name: "Stuart", email: "stuart@email.com", password: "Password", address: "Avenida stuart little 3", zip: "23000-000", cpf: "06516551022")

    login_as(new_user)
    visit new_auction_lot_path

    expect(current_path).to eq root_path
    expect(page).to have_content "You do not have permission to access this page."
  end
end
    