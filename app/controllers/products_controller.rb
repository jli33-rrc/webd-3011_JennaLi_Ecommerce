class ProductsController < ApplicationController
  layout "public"

  def show
    @product = Product.find(params[:id])
  end
end
