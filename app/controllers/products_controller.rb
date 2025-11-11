class ProductsController < ApplicationController
  layout "public"

  def show
    @category = Category.find_by!("LOWER(REPLACE(category_name, ' ', '-')) = ?", params[:category_name].downcase)
    @product = @category.products.find_by!("LOWER(REPLACE(product_name, ' ', '-')) = ?", params[:product_name].downcase)
    @featured_products = Product.order("RANDOM()").limit(4)
  end
end
