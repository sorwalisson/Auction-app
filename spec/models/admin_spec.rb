require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    context 'validations name' do
      it 'name must be present' do
        new_admin = Admin.new(name: "", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ99FF6345")

        expect(new_admin.valid?).to be_falsy
      end
    end

    context 'cpf validations' do
      it 'cpf must be present' do
        new_admin = Admin.new(name: "Walisson", cpf: "", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ99FF6345")

        expect(new_admin.valid?).to be_falsy
      end

      it 'must be unique' do
        new_admin = Admin.create!(name: "Walisson", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105BYZ55")
        second_admin = Admin.new(name: "Daniel", cpf: "72601326042", email: "Daniel@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105BYZ55")

        expect(second_admin.valid?).to be_falsy
      end

      it 'it must be a valid cpf' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326055", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105BYZ55")

        expect(new_admin.valid?).to be_falsy
      end
    end

    context 'validation_code' do
      it 'it must be present' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "")

        expect(new_admin.valid?).to be_falsy
      end

      it 'it must be a valid code' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105B51235")

        expect(new_admin.valid?).to be_falsy
      end

      it 'check if everything works if its valid' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105BYZ55")

        expect(new_admin.valid?).to be_truthy
      end
    end

    context 'validates email' do
      it 'must be present' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "", password: 'password', validation_code: "XYZ105BYZ55")

        expect(new_admin.valid?).to be_falsy
      end

      it 'it must ends with leilaodogalpao.com.br' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "walisson@gmail.com.br", password: 'password', validation_code: "XYZ105BYZ55")
        
        expect(new_admin.valid?).to be_falsy
      end

      it 'check if valids params works' do
        new_admin = Admin.new(name: "Walisson", cpf: "72601326042", email: "walisson@leilaodogalpao.com.br", password: 'password', validation_code: "XYZ105BYZ55")

        expect(new_admin.valid?).to be_truthy
      end
    end
  end
end
