require 'test_helper'

class SourcePagesControllerTest < ActionController::TestCase
  setup do
    @source_page = source_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_page" do
    assert_difference('SourcePage.count') do
      post :create, source_page: { url: @source_page.url }
    end

    assert_redirected_to source_page_path(assigns(:source_page))
  end

  test "should show source_page" do
    get :show, id: @source_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_page
    assert_response :success
  end

  test "should update source_page" do
    patch :update, id: @source_page, source_page: { url: @source_page.url }
    assert_redirected_to source_page_path(assigns(:source_page))
  end

  test "should destroy source_page" do
    assert_difference('SourcePage.count', -1) do
      delete :destroy, id: @source_page
    end

    assert_redirected_to source_pages_path
  end
end
