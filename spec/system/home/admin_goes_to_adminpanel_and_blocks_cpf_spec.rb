require 'rails_helper'

describe 'admin goes to admin panel to put cpf on blacklist' do
  it 'successfully' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                            zip: "57000-100", cpf: "36454796000")
    
    login_as(new_admin)                        
    visit root_path
    click_on "Admin Menu"
    within("div#blockcpf") do
      fill_in "Block CPF", with: "69831456076"
      click_on "Send"
    end
    new_user = User.new(name: "Dummy", email: "dummy@testingdummy.com", password: "password", address: "Dummy city, 32", zip: "00000-000", cpf: "69831456076")

    expect(current_path).to eq root_path
    expect(page).to have_content "The CPF was added to the blocklist successfully!"
    expect(new_user.valid?).to be_falsy
  end
    
end