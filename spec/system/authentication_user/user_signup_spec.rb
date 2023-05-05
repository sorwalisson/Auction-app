require 'rails_helper'

describe 'user signup' do
  it 'user go to sign up page and sign up' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'Name', with: "Walisson"
    fill_in 'Email', with: 'sorwalisson@email.com.br'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: "password"
    fill_in 'Address', with: 'Avenida Fernandes Lima, 35'
    fill_in 'Zip', with: '57000-100'
    fill_in 'CPF', with: "09814576492"
    click_on 'Register'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Walisson - sorwalisson@email.com'
    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_button "Logout"
    expect(page).to_not have_link "Sign up as user"
  end

  it 'admin signs up and see that the account is marked as admin' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'Name', with: "Walisson"
    fill_in 'Email', with: 'sorwalisson@leilaodogalpao.com.br'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: "password"
    fill_in 'Address', with: 'Avenida Fernandes Lima, 35'
    fill_in 'Zip', with: '57000-100'
    fill_in 'CPF', with: "09814576492"
    click_on 'Register'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Walisson - sorwalisson@leilaodogalpao.com.br'
    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_button "Logout"
    expect(page).to have_content "Hello Admin!"
  end
end