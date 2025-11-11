class CategoriesController < ApplicationController
  layout "public"

  def show
    @category = Category.find_by!("LOWER(REPLACE(category_name, ' ', '-')) = ?", params[:category_name].downcase)
    @products = @category.products.includes(:category, image_attachment: :blob)
    @featured_products = Product.order("RANDOM()").limit(4)
  end
end
