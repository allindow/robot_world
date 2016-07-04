require_relative "../test_helper"

class UserCanDeleteARobotTest < FeatureTest
  def test_user_can_delete_a_robot
    visit "/"
    click_link "Create a Robot"
    assert_equal "/robots/new", current_path
    page.fill_in "robotname", with: "Henrietta"
    click_button "Make My Robot!"
    assert_equal "/robots", current_path
    assert page.has_content? "Henrietta"
    click_on "Delete"
    assert_equal "/robots", current_path
    refute page.has_content? "Henrietta"
  end
end
