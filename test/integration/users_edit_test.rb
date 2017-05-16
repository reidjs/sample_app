require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:reid)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    #assert_no_difference 'div#error_explanation', "The form contains 4 errors."
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user) #go to the edit page
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {user: { name: name,
                                            email: email,
                                            password: "",
                                            password_confirmation:""} }
    assert_not flash.empty? #flash a method, something like 'details updated'
    assert_redirected_to @user #back to profile page
    @user.reload #with updated details
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
