require 'test_helper'

class DocumentationLinksControllerTest < ActionController::TestCase
  setup do
    @documentation_link = documentation_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documentation_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documentation_link" do
    assert_difference('DocumentationLink.count') do
      post :create, documentation_link: { active: @documentation_link.active, course_id: @documentation_link.course_id, link: @documentation_link.link, name: @documentation_link.name }
    end

    assert_redirected_to documentation_link_path(assigns(:documentation_link))
  end

  test "should show documentation_link" do
    get :show, id: @documentation_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @documentation_link
    assert_response :success
  end

  test "should update documentation_link" do
    patch :update, id: @documentation_link, documentation_link: { active: @documentation_link.active, course_id: @documentation_link.course_id, link: @documentation_link.link, name: @documentation_link.name }
    assert_redirected_to documentation_link_path(assigns(:documentation_link))
  end

  test "should destroy documentation_link" do
    assert_difference('DocumentationLink.count', -1) do
      delete :destroy, id: @documentation_link
    end

    assert_redirected_to documentation_links_path
  end
end
