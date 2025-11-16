class CartController < ApplicationController
  layout "public"
  before_action :initialize_cart

  def show
    product_ids = session[:cart].keys
    @cart_items = Product.where(id: product_ids)
  end

  def add
    pid = params[:id].to_s
    session[:cart][pid] ||= 0
    session[:cart][pid] += 1
    redirect_to cart_path, notice: "Added to cart."
  end

  def update
    pid = params[:id].to_s
    qty = params[:quantity].to_i

    if qty <= 0
      session[:cart].delete(pid)
    else
      session[:cart][pid] = qty
    end

    redirect_to cart_path, notice: "Cart updated."
  end

  def remove
    session[:cart].delete(params[:id].to_s)
    redirect_to cart_path, notice: "Item removed."
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end
end
