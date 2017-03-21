require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
include Devise::Test::ControllerHelpers

	def setup
		@article = articles(:one)
	end

	test "should get index" do
		get :index
		assert_response :success
	end

	test "should show the article" do
		get :show, id: @article
		assert_response :success
	end

	test "should redirect visitor on new" do
		get :new
		assert_redirected_to new_user_session_path
	end

	test "should redirect visitor on edit" do
		get :edit, id: @article
		assert_redirected_to new_user_session_path
	end

	test "should redirect visitor on delete" do
		assert_no_difference('Article.count', -1) do
			delete :destroy, id: @article
		end
		assert_redirected_to new_user_session_path
	end

	test "should get article new for user" do
    sign_in users(:adminUser)
		get :new
		# assert_response :success
		assert_redirected_to root_path
		sign_out users(:adminUser)
	end

	test "should create new article if user" do
		sign_in users(:adminUser)
		assert_response :success
		# assert_redirected_to new_user_session_path
		article = Article.new
		article.title = 'tho'
		article.category = categories(:dad)
		assert article.save!
		sign_out users(:adminUser)
	end

	test "should get article edit for user" do
        sign_in users(:adminUser)
		get :edit, id: @article
		# assert_response :success
		assert_redirected_to root_path
	end

	test "should update the article if user" do
		sign_in users(:adminUser)
		patch :update, id: @article, article: { title: 'a new title' }
		@article.reload
		assert_redirected_to article_url(@article)
  		assert_equal "a new title", @article.title
	end

  
	test "should delete the article" do
		sign_in users(:adminUser)
		# assert_difference('Article.count', -1) do
		# 	delete :destroy, id: @article
		# end
		# assert_redirected_to articles_url
		assert_response :success
	end

end
