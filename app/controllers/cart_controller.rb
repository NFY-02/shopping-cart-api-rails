class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @total_price = calculate_total_price
  end

  def add_to_cart
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    @total_price = calculate_total_price

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "cart_count",
            partial: "cart/cart_count",
            locals: { cart_count: session[:cart].values.sum }
          ),
          turbo_stream.replace(
            "total-price",
            partial: "cart/total_price",
            locals: { total_price: @total_price }
          )
        ]
      end
      format.html { redirect_to root_path, notice: "Product added to cart" }
    end
  end

  def update_quantity
    product_id = params[:product_id].to_s
    new_quantity = params[:quantity].to_i

    session[:cart] ||= {}

    if new_quantity > 0
      session[:cart][product_id] = new_quantity
    else
      session[:cart].delete(product_id)
    end

    product = find_product(product_id)
    @total_price = calculate_total_price

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "cart_count",
            partial: "cart/cart_count",
            locals: { cart_count: session[:cart].values.sum }
          ),
          turbo_stream.replace(
            "quantity-#{product_id}",
            partial: "cart/cart_quantity",
            locals: { product: product, quantity: new_quantity }
          ),
          turbo_stream.replace(
            "quantity-display-#{product_id}",
            partial: "cart/quantity_display",
            locals: { quantity: new_quantity }
          ),
          turbo_stream.replace(
            "total-price",
            partial: "cart/total_price",
            locals: { total_price: @total_price }
          )
        ]
      end
      format.html { redirect_to cart_path, notice: "Cart has been updated" }
    end
  end

  def remove_from_cart
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)

    @total_price = calculate_total_price

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "cart_items",
            partial: session[:cart].any? ? "cart/cart_items" : "cart/cart_empty",
            locals: { cart: session[:cart] }
          ),
          turbo_stream.replace(
            "cart_count",
            partial: "cart/cart_count",
            locals: { cart_count: session[:cart].values.sum }
          ),
          turbo_stream.replace(
            "total-price",
            partial: "cart/total_price",
            locals: { total_price: @total_price }
          )
        ]
      end
      format.html { redirect_to cart_path, notice: "Product removed from cart" }
    end
  end


  def clear_cart
    session[:cart] = {}
    redirect_to cart_path, notice: "Cart cleared"
  end

  private
  def find_product(product_id)
    Product.find(product_id)
  end

  def calculate_total_price
    session[:cart].sum do |product_id, quantity|
      product = find_product(product_id)
      product.price * quantity
    end
  end
end
