class ProductsController < ApplicationController
  layout "public"

  def show
    @category = Category.find_by!("LOWER(REPLACE(category_name, ' ', '-')) = ?", params[:category_name].downcase)
    @product = @category.products.find_by!("LOWER(REPLACE(product_name, ' ', '-')) = ?", params[:product_name].downcase)
  end
end
