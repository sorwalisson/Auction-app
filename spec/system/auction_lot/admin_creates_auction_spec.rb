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
    click_on "Create Auction"


    expect(page).to have_content "The new auction was created sucessfully!"
    expect(page).to have_content "Lot Code: cxt890953"
    expect(page).to have_content "Starts At: #{5.hours.from_now}"
    expect(page).to have_content "Ends At: #{3.days.from_now}"
    expect(page).to have_content "Starting Bid: 5000"
    expect(page).to have_content "Bid Difference: 5%"
    expect(page).to have_content "Status: draft"
    expect(page).to have_content "Created by: Walisson - sorwalisson@leilaodogalpao.com.br"
  end
end
    