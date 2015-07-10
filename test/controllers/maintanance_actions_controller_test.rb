require 'test_helper'

class MaintananceActionsControllerTest < ActionController::TestCase
  setup do
    @maintanance_action = maintanance_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintanance_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintanance_action" do
    assert_difference('MaintananceAction.count') do
      post :create, maintanance_action: { date: @maintanance_action.date, maintanance_type_id: @maintanance_action.maintanance_type_id, person_id: @maintanance_action.person_id, tool_id: @maintanance_action.tool_id }
    end

    assert_redirected_to maintanance_action_path(assigns(:maintanance_action))
  end

  test "should show maintanance_action" do
    get :show, id: @maintanance_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintanance_action
    assert_response :success
  end

  test "should update maintanance_action" do
    patch :update, id: @maintanance_action, maintanance_action: { date: @maintanance_action.date, maintanance_type_id: @maintanance_action.maintanance_type_id, person_id: @maintanance_action.person_id, tool_id: @maintanance_action.tool_id }
    assert_redirected_to maintanance_action_path(assigns(:maintanance_action))
  end

  test "should destroy maintanance_action" do
    assert_difference('MaintananceAction.count', -1) do
      delete :destroy, id: @maintanance_action
    end

    assert_redirected_to maintanance_actions_path
  end
end
