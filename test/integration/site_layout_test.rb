require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:reid)
  end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", helf_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Signup")
    assert_select "a[href=?]", login_path
    #repeated code from users login test
    log_in_as(@user)
    assert is_logged_in? 
    assert_redirected_to @user 
    follow_redirect!
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_path(@user)
    
    
  end
  
end
