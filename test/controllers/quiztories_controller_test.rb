require 'test_helper'

class QuiztoriesControllerTest < ActionController::TestCase
  setup do
    @quiztory = quiztories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiztories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiztory" do
    assert_difference('Quiztory.count') do
      post :create, quiztory: { failed_submits: @quiztory.failed_submits, finished_at: @quiztory.finished_at, quiz_id: @quiztory.quiz_id }
    end

    assert_redirected_to quiztory_path(assigns(:quiztory))
  end

  test "should show quiztory" do
    get :show, id: @quiztory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiztory
    assert_response :success
  end

  test "should update quiztory" do
    patch :update, id: @quiztory, quiztory: { failed_submits: @quiztory.failed_submits, finished_at: @quiztory.finished_at, quiz_id: @quiztory.quiz_id }
    assert_redirected_to quiztory_path(assigns(:quiztory))
  end

  test "should destroy quiztory" do
    assert_difference('Quiztory.count', -1) do
      delete :destroy, id: @quiztory
    end

    assert_redirected_to quiztories_path
  end
end
