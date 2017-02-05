require 'test_helper'

class PagesControllerTest < ActionController::TestCase
include Devise::Test::ControllerHelpers

	def setup
		@page = pages(:page)
	end


	test "should get index" do
		get :index
		assert_response :success
	end

	test "should show the page" do
		get :show, id: @page
		assert_response :success
	end

	test "should redirect visitor on new" do
		get :new
		assert_redirected_to new_user_session_path
	end

	test "should redirect visitor on edit" do
		get :edit, id: @page
		assert_redirected_to new_user_session_path
	end
end
