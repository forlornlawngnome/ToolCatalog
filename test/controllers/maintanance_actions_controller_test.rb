require 'test_helper'

class MaintenanceActionsControllerTest < ActionController::TestCase
  setup do
    @maintenance_action = maintenance_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenance_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance_action" do
    assert_difference('MaintenanceAction.count') do
      post :create, maintenance_action: { date: @maintenance_action.date, maintenance_type_id: @maintenance_action.maintenance_type_id, person_id: @maintenance_action.person_id, tool_id: @maintenance_action.tool_id }
    end

    assert_redirected_to maintenance_action_path(assigns(:maintenance_action))
  end

  test "should show maintenance_action" do
    get :show, id: @maintenance_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance_action
    assert_response :success
  end

  test "should update maintenance_action" do
    patch :update, id: @maintenance_action, maintenance_action: { date: @maintenance_action.date, maintenance_type_id: @maintenance_action.maintenance_type_id, person_id: @maintenance_action.person_id, tool_id: @maintenance_action.tool_id }
    assert_redirected_to maintenance_action_path(assigns(:maintenance_action))
  end

  test "should destroy maintenance_action" do
    assert_difference('MaintenanceAction.count', -1) do
      delete :destroy, id: @maintenance_action
    end

    assert_redirected_to maintenance_actions_path
  end
end
