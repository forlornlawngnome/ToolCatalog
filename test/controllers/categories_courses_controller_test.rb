require 'test_helper'

class CategoriesCoursesControllerTest < ActionController::TestCase
  setup do
    @categories_course = categories_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories_course" do
    assert_difference('CategoriesCourse.count') do
      post :create, categories_course: { category_id: @categories_course.category_id, course_id: @categories_course.course_id }
    end

    assert_redirected_to categories_course_path(assigns(:categories_course))
  end

  test "should show categories_course" do
    get :show, id: @categories_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categories_course
    assert_response :success
  end

  test "should update categories_course" do
    patch :update, id: @categories_course, categories_course: { category_id: @categories_course.category_id, course_id: @categories_course.course_id }
    assert_redirected_to categories_course_path(assigns(:categories_course))
  end

  test "should destroy categories_course" do
    assert_difference('CategoriesCourse.count', -1) do
      delete :destroy, id: @categories_course
    end

    assert_redirected_to categories_courses_path
  end
end
