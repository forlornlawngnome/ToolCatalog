require 'test_helper'

class CoursesPeopleControllerTest < ActionController::TestCase
  setup do
    @courses_person = courses_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create courses_person" do
    assert_difference('CoursesPerson.count') do
      post :create, courses_person: { approval_date: @courses_person.approval_date, approved: @courses_person.approved, approver: @courses_person.approver, course_id: @courses_person.course_id, date_requested: @courses_person.date_requested, person_id: @courses_person.person_id }
    end

    assert_redirected_to courses_person_path(assigns(:courses_person))
  end

  test "should show courses_person" do
    get :show, id: @courses_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @courses_person
    assert_response :success
  end

  test "should update courses_person" do
    patch :update, id: @courses_person, courses_person: { approval_date: @courses_person.approval_date, approved: @courses_person.approved, approver: @courses_person.approver, course_id: @courses_person.course_id, date_requested: @courses_person.date_requested, person_id: @courses_person.person_id }
    assert_redirected_to courses_person_path(assigns(:courses_person))
  end

  test "should destroy courses_person" do
    assert_difference('CoursesPerson.count', -1) do
      delete :destroy, id: @courses_person
    end

    assert_redirected_to courses_people_path
  end
end
