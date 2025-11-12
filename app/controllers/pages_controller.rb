class PagesController < ApplicationController
  layout "public"
  
  def home
    @categories = Category.all
    @products = Product.includes(:category, image_attachment: :blob).all
                       .order(:id)
                       .page(params[:page]).per(12)
  end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
