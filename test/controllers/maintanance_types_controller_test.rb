require 'test_helper'

class MaintananceTypesControllerTest < ActionController::TestCase
  setup do
    @maintanance_type = maintanance_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintanance_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintanance_type" do
    assert_difference('MaintananceType.count') do
      post :create, maintanance_type: { category_id: @maintanance_type.category_id, name: @maintanance_type.name, required_hours_between_maintanance: @maintanance_type.required_hours_between_maintanance }
    end

    assert_redirected_to maintanance_type_path(assigns(:maintanance_type))
  end

  test "should show maintanance_type" do
    get :show, id: @maintanance_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintanance_type
    assert_response :success
  end

  test "should update maintanance_type" do
    patch :update, id: @maintanance_type, maintanance_type: { category_id: @maintanance_type.category_id, name: @maintanance_type.name, required_hours_between_maintanance: @maintanance_type.required_hours_between_maintanance }
    assert_redirected_to maintanance_type_path(assigns(:maintanance_type))
  end

  test "should destroy maintanance_type" do
    assert_difference('MaintananceType.count', -1) do
      delete :destroy, id: @maintanance_type
    end

    assert_redirected_to maintanance_types_path
  end
end
