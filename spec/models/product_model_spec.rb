require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe 'validations' do
    it 'name must be present' do
      new_product = ProductModel.new(name: "", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)
      
      expect(new_product.valid?).to be_falsy
    end

    it 'Description must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "",
                                weight: 247, height: 3, width: 8, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)
      
      expect(new_product.valid?).to be_falsy
    end
    
    it 'weight must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: nil, height: 3, width: 8, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)
      
      expect(new_product.valid?).to be_falsy
    end
    
    it 'height must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: nil, width: 8, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)

      expect(new_product.valid?).to be_falsy
    end

    it 'width must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: nil, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)

      expect(new_product.valid?).to be_falsy
    end

    it 'depth must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: nil, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: :technology)

      expect(new_product.valid?).to be_falsy
    end

    it 'image_url must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3, 
                                image_url: "",
                                category: :technology)

      expect(new_product.valid?).to be_falsy
    end

    it 'status must be present' do
      new_product = ProductModel.new(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                weight: 247, height: 3, width: 8, depth: 3, 
                                image_url: "https://images.kabum.com.br/produtos/fotos/129459/processador-amd-ryzen-9-5900x-cache-70mb-3-7ghz-4-8ghz-max-turbo-am4-100-100000063wof_1602600708_gg.jpg",
                                category: nil)

      expect(new_product.valid?).to be_falsy
    end
  end
end
