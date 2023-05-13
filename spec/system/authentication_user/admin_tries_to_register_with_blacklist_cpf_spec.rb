require 'rails_helper'

describe 'user tries to register with cpf that is on the blacklist' do
  it 'and cpf is blocked succcesfully' do
    BlackListCpf.create(cpf: "81553480406")

    visit root_path
    click_on "Sign Up"
    fill_in "Email", with: "daniel@daniel.com.br"
    fill_in "Name", with: "Daniel"
    fill_in "Zip", with: "57010-000"
    fill_in "CPF", with: "81553480406"
    fill_in 'Password', with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Address", with: "Rua alguma coisa, 15"
    click_on "Register"

    expect(current_path).to eq root_path
    expect(page).to have_content "You cannot register an account using this CPF"
  end
end