class ProductsController < ApplicationController
  def index
    Product.create_product

    Product.create_error_product

    Product.destroy_product

    Product.find_id
    Product.findby_title

    Product.product_photo
    Product.create_product_photo
  end
end
