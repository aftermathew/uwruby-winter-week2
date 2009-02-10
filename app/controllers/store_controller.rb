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

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end

  private
   def find_cart
     session[:cart] ||= Cart.new
   end

  def redirect_to_index (notice = nil)
    flash[:notice] = notice if notice
    redirect_to :action => 'index'
  end

end
