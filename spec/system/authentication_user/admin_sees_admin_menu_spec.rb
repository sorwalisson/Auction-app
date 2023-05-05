require "rails_helper"

describe "admin goes to admin menu" do
  it 'admin goes to admin menu and click on register a new product model' do
    new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                              zip: "57000-100", cpf: "09814576492")
    
    login_as(new_admin)
    visit root_path
    click_on "Admin Menu"
    click_on "Add a new product model"

    expect(current_path).to eq new_product_model_path
    expect(page).to have_content "New Product Model"
  end
end