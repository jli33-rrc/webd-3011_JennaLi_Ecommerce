class PagesController < ApplicationController
  layout "public"
  
  def home
    @products = Product.includes(image_attachment: :blob).all
  end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
