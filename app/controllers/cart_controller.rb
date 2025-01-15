class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    product_ids = @cart.keys
    @products = Product.where(id: product_ids)


    @total_sum = @products.price do |product|
      product.price * @cart[product.id.to_s].to_i
    end
  end
end
