require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  #def setup
  #  @base_title = "Reid's Ruby Page"
  #end 
  
  test "should get root" do
    get root_url
    assert_response :success
  end 
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | Reid's Ruby Page"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | Reid's Ruby Page"

  end
    
  test "should get about" do
      get static_pages_about_url
      assert_response :success
      #assert_select "title", "About | #{@base_title}"
      assert_select "title", "About | Reid's Ruby Page"
  end
  
  
end
