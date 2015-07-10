require 'test_helper'

class ToolLogsControllerTest < ActionController::TestCase
  setup do
    @tool_log = tool_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tool_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tool_log" do
    assert_difference('ToolLog.count') do
      post :create, tool_log: { duration: @tool_log.duration, person_id: @tool_log.person_id, time_in: @tool_log.time_in, time_out: @tool_log.time_out, tool_id: @tool_log.tool_id, tool_reservation_id: @tool_log.tool_reservation_id }
    end

    assert_redirected_to tool_log_path(assigns(:tool_log))
  end

  test "should show tool_log" do
    get :show, id: @tool_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tool_log
    assert_response :success
  end

  test "should update tool_log" do
    patch :update, id: @tool_log, tool_log: { duration: @tool_log.duration, person_id: @tool_log.person_id, time_in: @tool_log.time_in, time_out: @tool_log.time_out, tool_id: @tool_log.tool_id, tool_reservation_id: @tool_log.tool_reservation_id }
    assert_redirected_to tool_log_path(assigns(:tool_log))
  end

  test "should destroy tool_log" do
    assert_difference('ToolLog.count', -1) do
      delete :destroy, id: @tool_log
    end

    assert_redirected_to tool_logs_path
  end
end
