class StoreController < ApplicationController
  def index
    @cart = find_cart
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
    redirect_to_index
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index "Yo dawg, we don't have that thing in our inventory!"
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index "You can haz empty cart! No itemz!!"
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
