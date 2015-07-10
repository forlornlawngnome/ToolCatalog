require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { active: @person.active, barcode: @person.barcode, email: @person.email, emergency_contact_name: @person.emergency_contact_name, emergency_contact_number: @person.emergency_contact_number, graduation_year: @person.graduation_year, is_admin: @person.is_admin, is_student_admin: @person.is_student_admin, name: @person.name }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { active: @person.active, barcode: @person.barcode, email: @person.email, emergency_contact_name: @person.emergency_contact_name, emergency_contact_number: @person.emergency_contact_number, graduation_year: @person.graduation_year, is_admin: @person.is_admin, is_student_admin: @person.is_student_admin, name: @person.name }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
