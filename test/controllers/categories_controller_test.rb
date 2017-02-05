require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

	def setup
		@category = categories(:dad)
	end

	test "should get index" do
		get :index
		assert_response :success
	end

	test "should show the category" do
		get :show, id: @category
		assert_response :success
	end

	test "should redirect visitor on new" do
		get :new
		assert_redirected_to new_user_session_path
	end

	test "should redirect visitor on edit" do
		get :edit, id: @category
		assert_redirected_to new_user_session_path
	end
end
