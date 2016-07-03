require_relative "../test_helper"

class UserCanCreateARobotTest < FeatureTest
  def test_user_can_edit_a_robot
    visit "/"
    click_link "Create a Robot"
    assert_equal "/robots/new", current_path
    page.fill_in "robotname", with: "Henrietta"
    click_button "Make My Robot!"
    assert_equal "/robots", current_path
    click_link "Edit"
    assert page.has_content? "Edit Robot"
    page.fill_in "robotname", with: "Trinity"
    click_button "Change My Robot!"
    assert_equal "/robots", current_path
    click_link "Trinity"
    assert page.has_content? "This is Trinity!"
  end
end
