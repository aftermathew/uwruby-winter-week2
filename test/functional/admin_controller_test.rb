require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "i am logged in!" do
    @request.session[:user_id] = users(:one).id
    get :index
    assert_response :success
  end

  test "i am not logged in" do
    get :index
    assert_redirected_to :action => 'login'
  end

  test "i was logged until i logged out" do
    @request.session[:user_id] = users(:one).id
    get :index
    assert_response :success

    get :logout
    assert_redirected_to :action => 'login'

    get :index
    assert_redirected_to :action => 'login'
  end

end
