class ProductsController < ApplicationController
  layout "public"

  def show
    @category = Category.find_by!("LOWER(REPLACE(category_name, ' ', '-')) = ?", params[:category_name].downcase)
    @product = @category.products.find_by!("LOWER(REPLACE(product_name, ' ', '-')) = ?", params[:product_name].downcase)
    @featured_products = Product.order("RANDOM()").limit(4)
  end

  def search
    @categories = Category.all
    @products = Product.all

    if params[:q].present?
      keyword = "%#{params[:q]}%"
      @products = @products.where(
        "product_name LIKE ? OR description LIKE ?",
        keyword, keyword
      )
    end

    if params[:category_id].present? && params[:category_id] != ""
      @products = @products.where(category_id: params[:category_id])
    end

    render "pages/home"
  end
end
