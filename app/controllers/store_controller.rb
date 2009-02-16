class StoreController < ApplicationController
  def index
    @cart = find_cart
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(product)
    respond_to do |format|
      format.js
      format.html {redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index "Yo dawg, we don't have that thing in our inventory!"
  end

  def save_order
    @cart = find_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      redirect_to_index("Thank you for your order")
    else
      render :action => 'checkout'
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end


  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("How much would you charge you for selling you nothing?")
    else
      @order = Order.new
    end
  end


  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end

  private
  def authorize
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def redirect_to_index (notice = nil)
    flash[:notice] = notice if notice
    redirect_to :action => 'index'
  end

end
