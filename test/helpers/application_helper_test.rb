require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,      "Brooklyn Lifting Club"
    assert_equal full_title("Help"), "Help | Brooklyn Lifting Club"
  end
end