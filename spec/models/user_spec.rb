require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'presence: true' do
      it 'name must be present' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: '', cpf: "72601326042", 
                            address: "Avenida Durval de Goes Monteiro, 250", zip: "57071-120")

        expect(new_user.valid?).to be_falsy
      end

      it 'address must be present' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: 'Walisson', cpf: "72601326042", 
                            address: "", zip: "57071-120")

        expect(new_user.valid?).to be_falsy
      end

      it 'cpf must be present' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: 'Walisson', cpf: "", 
                            address: "Avenida Durval de Goes Monteiro, 250", zip: "57071-120")

        expect(new_user.valid?).to be_falsy
      end

      it 'zip must be present' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: '', cpf: "72601326042", 
                            address: "Avenida Durval de Goes Monteiro, 250", zip: "")

        expect(new_user.valid?).to be_falsy
      end
    end

    context 'cpf uniqueness' do
      it 'cpf must be unique' do
        User.create!(email: "walisson@santos.com", password: "password", name: 'Walisson', cpf: "72601326042", 
                     address: "Avenida Durval de Goes Monteiro, 250", zip: "57071-120")
        new_user = User.new(email: "Zezin@oliveira.com", password: "password", name: "zezin", cpf: "72601326042", 
                            address: "Rua do zezin 888", zip: "57000-000")
        expect(new_user.valid?).to be_falsy
      end
    end

    context 'cpf must be a valid cpf.' do
      it 'it must be a valid cpf, case when cpf is negative' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: 'Walisson', cpf: "44444444444", 
                            address: "Avenida Durval de Goes Monteiro, 250", zip: "57071-120")    
        
        expect(new_user.valid?).to be_falsy
      end

      it 'it must be a valid cpf, case when cpf is positive' do
        new_user = User.new(email: "walisson@santos.com", password: "password", name: 'Walisson', cpf: "72601326042", 
                            address: "Avenida Durval de Goes Monteiro, 250", zip: "57071-120")    

        expect(new_user.valid?).to be_truthy
      end
    end
  end
end
