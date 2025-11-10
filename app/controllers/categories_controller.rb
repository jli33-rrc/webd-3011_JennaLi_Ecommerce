class CategoriesController < ApplicationController
  layout "public"

  def show
    @category = Category.find_by!(category_name: params[:category_name])
    @products = @category.products.includes(:category, image_attachment: :blob)
  end
end
