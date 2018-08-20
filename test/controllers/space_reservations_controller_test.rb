require 'test_helper'

class SpaceReservationsControllerTest < ActionController::TestCase
  setup do
    @space_reservation = space_reservations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:space_reservations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create space_reservation" do
    assert_difference('SpaceReservation.count') do
      post :create, space_reservation: { number_of_people: @space_reservation.number_of_people, person_id: @space_reservation.person_id, reservation_beginning: @space_reservation.reservation_beginning, reservation_ending: @space_reservation.reservation_ending, space_id: @space_reservation.space_id }
    end

    assert_redirected_to space_reservation_path(assigns(:space_reservation))
  end

  test "should show space_reservation" do
    get :show, id: @space_reservation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @space_reservation
    assert_response :success
  end

  test "should update space_reservation" do
    patch :update, id: @space_reservation, space_reservation: { number_of_people: @space_reservation.number_of_people, person_id: @space_reservation.person_id, reservation_beginning: @space_reservation.reservation_beginning, reservation_ending: @space_reservation.reservation_ending, space_id: @space_reservation.space_id }
    assert_redirected_to space_reservation_path(assigns(:space_reservation))
  end

  test "should destroy space_reservation" do
    assert_difference('SpaceReservation.count', -1) do
      delete :destroy, id: @space_reservation
    end

    assert_redirected_to space_reservations_path
  end
end
