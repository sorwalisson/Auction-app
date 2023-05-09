require "rails_helper"

describe "admin goes to admin menu" do
  it 'admin goes to admin menu and see options' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             zip: "57000-100", cpf: "09814576492")
    
    login_as(new_admin)
    visit root_path
    click_on "Admin Menu"

    expect(current_path).to eq admin_menu_path
    expect(page).to have_content "Admin Menu"
    expect(page).to have_content "Creation Section"
    expect(page).to have_content "Draft auctions"
  end
end