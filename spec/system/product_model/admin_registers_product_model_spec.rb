#require 'rails_helper'

#describe 'admin registers a new product model' do
  #it 'sucessfully' do
    #new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                             #zip: "57000-100", cpf: "09814576492")

    #login_as(new_admin)
    #visit root_path
    #click_on "Admin Menu"
    #click_on "Add a new product model"
    #fill_in "Name", with: "Ryzen 7 5800x"
    #fill_in "Description", with: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture."
    #fill_in "Weight", with: 333
    #fill_in "Height", with: 3
    #fill_in "Width", with: 4
    #fill_in "Depth", with: 3
    #fill_in "Image URL", with: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg"
    #select "Ryzen 7 5800x", from: "Category"
    #click_on "Save"

    #expect(current_path).to eq product_model_path(id: ProductModel.first.id)
    #expect(page).to have_content "Product Model was created sucessfully!"
  #end
#end   
