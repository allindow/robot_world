require_relative "../test_helper"

class UserCanCreateARobotTest < FeatureTest

  def test_user_can_create_a_robot
    visit "/"
    click_link "Create a Robot"
    assert_equal "/robots/new", current_path
    click_button "Make My Robot!"
    assert_equal "/robots", current_path
    assert page.has_css?("#title")
    assert page.has_content?("All Robots")
  end

end
