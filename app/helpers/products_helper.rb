module ProductsHelper
  def price(product)
    number_to_currency(product.price)
  end

  def main_image(product)
    if product.main_image.attached?
      image_tag product.main_image
    else
      image_tag "placeholder.png"
    end
  end
end
