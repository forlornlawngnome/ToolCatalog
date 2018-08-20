require 'test_helper'

class HourExceptionsControllerTest < ActionController::TestCase
  setup do
    @hour_exception = hour_exceptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hour_exceptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hour_exception" do
    assert_difference('HourException.count') do
      post :create, hour_exception: { date: @hour_exception.date, person_id: @hour_exception.person_id, time_beginning: @hour_exception.time_beginning, time_ending: @hour_exception.time_ending }
    end

    assert_redirected_to hour_exception_path(assigns(:hour_exception))
  end

  test "should show hour_exception" do
    get :show, id: @hour_exception
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hour_exception
    assert_response :success
  end

  test "should update hour_exception" do
    patch :update, id: @hour_exception, hour_exception: { date: @hour_exception.date, person_id: @hour_exception.person_id, time_beginning: @hour_exception.time_beginning, time_ending: @hour_exception.time_ending }
    assert_redirected_to hour_exception_path(assigns(:hour_exception))
  end

  test "should destroy hour_exception" do
    assert_difference('HourException.count', -1) do
      delete :destroy, id: @hour_exception
    end

    assert_redirected_to hour_exceptions_path
  end
end
