require 'test_helper'

class CategoriesToolsControllerTest < ActionController::TestCase
  setup do
    @categories_tool = categories_tools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories_tool" do
    assert_difference('CategoriesTool.count') do
      post :create, categories_tool: { category_id: @categories_tool.category_id, tool_id: @categories_tool.tool_id }
    end

    assert_redirected_to categories_tool_path(assigns(:categories_tool))
  end

  test "should show categories_tool" do
    get :show, id: @categories_tool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categories_tool
    assert_response :success
  end

  test "should update categories_tool" do
    patch :update, id: @categories_tool, categories_tool: { category_id: @categories_tool.category_id, tool_id: @categories_tool.tool_id }
    assert_redirected_to categories_tool_path(assigns(:categories_tool))
  end

  test "should destroy categories_tool" do
    assert_difference('CategoriesTool.count', -1) do
      delete :destroy, id: @categories_tool
    end

    assert_redirected_to categories_tools_path
  end
end
