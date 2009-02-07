require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = Cart.new
  end

  def test_initialize
    assert_equal 0, @cart.items.length
  end

  def test_add_product
    @cart.add_product products(:one)
    assert_equal 1, @cart.items.length
    @cart.add_product products(:one)
    assert_equal 2, @cart.items.length
    @cart.add_product products(:two)
    assert_equal 3, @cart.items.length
  end

  def test_add_product
    @cart << products(:one)
    assert_equal 1, @cart.items.length
  end

  def test_price
    @cart << products(:one)
    @cart << products(:one)
    @cart << products(:two)

    assert(@cart.total_price == products(:one).price * 2 + products(:two).price)
  end

end
