require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  #define a user using the fixture 
  def setup
    @user = users(:reid)
    remember(@user)
  end
  #check that user is remembered
  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end
  #verify current user is given user
  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
