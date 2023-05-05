require 'rails_helper'

describe 'user visit home page' do
  it 'and see the name of the site, according to current language' do
    visit root_path

    expect(page).to have_link("Go Auction!")
    expect(page).to have_content("Where you buy your dreams")
    expect(page).to have_content('Welcome to Go Auction, Dreams on a bid distance!')
  end
end