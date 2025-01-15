class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    product_ids = @cart.keys
    @products = Product.where(id: product_ids)


    @total_sum = @products.price do |product|
      product.price * @cart[product.id.to_s].to_i
    end
  end

  def add_to_cart
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "cart_count",
          partial: "cart/cart_count",
          locals: { cart_count: session[:cart].values.sum }
        )
      end
      format.html { redirect_to root_path, notice: "Product added to cart" }
    end
  end
end
