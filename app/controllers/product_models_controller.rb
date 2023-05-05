class ProductModelsController < ApplicationController
  before_action :authenticate_user_admin, only: [:new, :create]
  
  def new
    @product_model = ProductModel.new()
  end
end