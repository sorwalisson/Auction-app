require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'name validations' do
      it 'it must be present' do
        new_user = User.new(name: "", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        
        expect(new_user.valid?).to be_falsy
      end
    end

    context 'cpf validations' do
      it 'it must be present' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
          address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "")

        expect(new_user.valid?).to be_falsy
      end

      it 'it must be unique' do
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        second_user = User.new(name: "Otávio", password: "password", email: 'otavio@email.com', 
                               address: "Rua 1, 50", zip: '57000-100', cpf: "72601326042")
        
        expect(second_user.valid?).to be_falsy
      end

      it 'it must be a valid cpf, case correct length but no valid' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72333321356")

        expect(new_user.valid?).to be_falsy
      end

      it 'it must have the correct length :11' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "723336")
        
        expect(new_user.valid?).to be_falsy
      end
    end

    context 'zip validations' do
      it 'it must be present' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "", cpf: "72601326042")
        
        expect(new_user.valid?).to be_falsy
      end

      it 'it must be a valid zip code, with correct length' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "570-100", cpf: "72601326042")

        expect(new_user.valid?).to be_falsy
      end

      it 'it must not have non number characters other than the -' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "570ab-100", cpf: "72601326042")
        
        expect(new_user.valid?).to be_falsy
      end

      it 'it must have only one -' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "Avenida Fernandes Lima, 35", zip: "5702--100", cpf: "72601326042")
        
        expect(new_user.valid?).to be_falsy
      end
    end

    context 'address validations' do
      it 'address must be present' do
        new_user = User.new(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                            address: "", zip: "57000-100", cpf: "72601326042")
        
        expect(new_user.valid?).to be_falsy
      end
    end

    context 'email validations' do
      it 'if email != @leilaodogalpao.com.br then it should be regular user' do
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@email.com', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
        
        expect(new_user.admin?).to be_falsy
      end

      it 'if email ends with @leilaodogalpao.com.br the it must be admin' do
        new_user = User.create!(name: "Walisson", password: "password", email: 'sorwalisson@leilaodogalpao.com.br', 
                                address: "Avenida Fernandes Lima, 35", zip: "57000-100", cpf: "72601326042")
                              
        expect(new_user.admin?).to be_truthy
      end
    end
  end
end
