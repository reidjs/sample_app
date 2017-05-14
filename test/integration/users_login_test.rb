require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:reid)
  end
  
  test "login with invalid information" do
    get login_path #route to the login screen
    assert_template 'sessions/new' #make sure new view template rendered
    post login_path, params: { session: { email: "", password: "" } } #post invalid login
    assert_template 'sessions/new' #new template should still be rendered
    assert_not flash.empty? #make sure the flash message popped up
    get root_path #go to different page
    assert flash.empty? #make sure the flash message did not pop up
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in? #from test_helper
    assert_redirected_to @user 
    follow_redirect! #go to the redirected page
    assert_template 'users/show' #should go to the users page at this point
    assert_select "a[href=?]", login_path, count: 0 #login should not show up anymore
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count:0
    assert_select "a[href=?]", user_path(@user), count:0
  end
  
end
