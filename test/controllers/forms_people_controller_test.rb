require 'test_helper'

class FormsPeopleControllerTest < ActionController::TestCase
  setup do
    @forms_person = forms_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forms_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forms_person" do
    assert_difference('FormsPerson.count') do
      post :create, forms_person: { form_id: @forms_person.form_id, person_id: @forms_person.person_id }
    end

    assert_redirected_to forms_person_path(assigns(:forms_person))
  end

  test "should show forms_person" do
    get :show, id: @forms_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forms_person
    assert_response :success
  end

  test "should update forms_person" do
    patch :update, id: @forms_person, forms_person: { form_id: @forms_person.form_id, person_id: @forms_person.person_id }
    assert_redirected_to forms_person_path(assigns(:forms_person))
  end

  test "should destroy forms_person" do
    assert_difference('FormsPerson.count', -1) do
      delete :destroy, id: @forms_person
    end

    assert_redirected_to forms_people_path
  end
end
