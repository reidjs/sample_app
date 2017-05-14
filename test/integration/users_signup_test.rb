require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    #make sure the count doesnt change after adding an invalid user
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@inva",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    #assert_template 'users/new'
    #Test the error messages individually
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end
  
  test "valid signup info" do
    get signup_path #go to the sign up page
    assert_difference 'User.count', 1 do #make sure user count changed by +1
      post users_path, params: {user: { name: "Example person",
                                        email: "example@example.com",
                                        password:"password",
                                        password_confirmation:"password" } }
    end
    follow_redirect! #go to the redirect 
    assert_template 'users/show' #make sure the users page shows up
    assert_not flash.empty? #make sure the flash shows up
  end
end
