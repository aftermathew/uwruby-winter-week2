class StoreController < ApplicationController
  before_filter :find_cart, :except => :empty_cart
  def index
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    product = Product.find(params[:id])
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
  def find_cart
    @cart = session[:cart] ||= Cart.new
  end

  def redirect_to_index (notice = nil)
    flash[:notice] = notice if notice
    redirect_to :action => 'index'
  end

  protected
  def authorize
  end

end
