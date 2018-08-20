require 'test_helper'

class ToolReservationsControllerTest < ActionController::TestCase
  setup do
    @tool_reservation = tool_reservations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tool_reservations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tool_reservation" do
    assert_difference('ToolReservation.count') do
      post :create, tool_reservation: { person_id: @tool_reservation.person_id, reservation_beginning: @tool_reservation.reservation_beginning, reservation_ending: @tool_reservation.reservation_ending, tool_id: @tool_reservation.tool_id }
    end

    assert_redirected_to tool_reservation_path(assigns(:tool_reservation))
  end

  test "should show tool_reservation" do
    get :show, id: @tool_reservation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tool_reservation
    assert_response :success
  end

  test "should update tool_reservation" do
    patch :update, id: @tool_reservation, tool_reservation: { person_id: @tool_reservation.person_id, reservation_beginning: @tool_reservation.reservation_beginning, reservation_ending: @tool_reservation.reservation_ending, tool_id: @tool_reservation.tool_id }
    assert_redirected_to tool_reservation_path(assigns(:tool_reservation))
  end

  test "should destroy tool_reservation" do
    assert_difference('ToolReservation.count', -1) do
      delete :destroy, id: @tool_reservation
    end

    assert_redirected_to tool_reservations_path
  end
end
