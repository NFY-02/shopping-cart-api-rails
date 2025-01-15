class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end
end
