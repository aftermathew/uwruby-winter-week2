require 'test_helper'

class CartItemTest < ActiveSupport::TestCase

  def setup
    @item = CartItem.new products(:one)
  end

  def test_initialize
    assert(@item.quantity == 1)
    assert(@item.product == products(:one))
  end

  def test_increment_quantity
    assert(@item.increment_quantity == 2)
    assert(@item.increment_quantity == 3)
  end

  def test_increment_quantity
    price = products(:one).price
    assert(price == @item.price)

    @item.increment_quantity
    assert(price * 2 == @item.price)

    @item.increment_quantity
    assert(price * 3 == @item.price)
  end
end

