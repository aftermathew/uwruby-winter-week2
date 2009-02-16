require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => {
        :title        => 'awesome product',
        :description  => 'awesome product description',
        :image_url    => 'http://example.com/foo.gif',
        :price        => '100'
      }
      assert_match /created/i, flash[:notice]
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => products(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => products(:one).id
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
    assert_response :success
  end

  test "should update product" do
    put :update, :id => products(:one).id, :product => {
      :title => 'mega awesome title'
    }
    assert_redirected_to product_path(assigns(:product))
    assert_equal 'mega awesome title', Product.find(products(:one).id).title
    assert_match /updated/i, flash[:notice]
  end

  test "products must have title" do
    put :update, :id => products(:one).id, :product => {
      :title => ''
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_title", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Title"

  end


  test "products must long title" do
    put :update, :id => products(:one).id, :product => {
      :title => 'short'
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_title", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Title"

  end


  test "products must be priced reasonably" do
    put :update, :id => products(:one).id, :product => {
      :price => ''
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_price", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Price"

    put :update, :id => products(:one).id, :product => {
      :price => '-10'
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_price", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Price"
  end

  test "products must have good image" do
    put :update, :id => products(:one).id, :product => {
      :image_url => ''
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_image_url", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Image url"

    put :update, :id => products(:one).id, :product => {
      :image_url => 'I sing in the shower'
    }

    assert_response :success
    assert_select "div.fieldWithErrors > input#product_image_url", :text => ""
    assert_select "div.fieldWithErrors > label", :text => "Image url"
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:one).id
    end

    assert_redirected_to products_path
  end
end

