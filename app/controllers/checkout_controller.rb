class CheckoutController < ApplicationController
  layout "public"

  def customer
    @customer = session[:customer_id] ? Customer.find(session[:customer_id]) : Customer.new
  end

  def save_customer
    if session[:customer_id]
      @customer = Customer.find(session[:customer_id])

      if @customer.update(customer_params)
        redirect_to checkout_invoice_path
      else
        render :customer
      end
    else
      @customer = Customer.new(customer_params)
      
      if @customer.save
        session[:customer_id] = @customer.id
        redirect_to checkout_invoice_path
      else
        render :customer
      end
    end
  end

  def invoice
    return redirect_to checkout_customer_path unless session[:customer_id].present?
    @customer = Customer.find(session[:customer_id])
    @cart_items = Product.find(session[:cart].keys)
    @subtotal = @cart_items.sum { |p| p.price * session[:cart][p.id.to_s] }
    
    province = @customer.province
    @gst = (@subtotal * (province.gst || 0)).round(2)
    @pst = (@subtotal * (province.pst || 0)).round(2)
    @hst = (@subtotal * (province.hst || 0)).round(2)
    @total = @subtotal + @gst + @pst + @hst
  end

  def confirm_purchase
    customer = Customer.find(session[:customer_id])
    cart_items = Product.find(session[:cart].keys)

    subtotal = cart_items.sum { |p| p.price * session[:cart][p.id.to_s] }

    province = customer.province
    gst = (subtotal * (province.gst || 0)).round(2)
    pst = (subtotal * (province.pst || 0)).round(2)
    hst = (subtotal * (province.hst || 0)).round(2)
    total = subtotal + gst + pst + hst

    purchase = Purchase.create!(
      customer: customer,
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      total: total
    )

    cart_items.each do |product|
      PurchaseProduct.create!(
        purchase: purchase,
        product: product,
        price: product.price,
        quantity: session[:cart][product.id.to_s]
      )
    end

    session[:cart] = {}
    session[:customer_id] = nil

    redirect_to checkout_complete_path(purchase.id)
  end

  def complete
    @purchase = Purchase.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address, :city, :postal_code, :province_id)
  end
end
