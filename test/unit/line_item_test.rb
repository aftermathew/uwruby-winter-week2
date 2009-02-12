require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "from cart item" do
    cart_item = CartItem.new(products(:one))
    line_item = LineItme.from_cart_item(cart_item)
    assert_equal products(:one), line_item.product
    assert_equal 1, line_item.quantity
    assert_equal products(:one).price, line_item.total_price
  end

  test "from cart item with many of the same product" do
    cart_item = CartItem.new(products(:one))
    cart_item.increment_quantity
    line_item = LineItme.from_cart_item(cart_item)

    assert_equal products(:one), line_item.product
    assert_equal cart_item.quantity, line_item.quantity
    assert_equal cart_item.price, line_item.total_price
  end

  test "line item can have an order" do
    line_item = line_items(:one)
    line_item.order = orders(:one)
    line_item.save!
    assert_equal(orders(:one), line_item.order)
  end
end
