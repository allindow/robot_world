require_relative "../test_helper"

class UserCanEditARobotTest < FeatureTest
  def test_user_can_view_stats_page
    visit "/"
    click_link "Robot World Statistics"
    assert_equal "/about", current_path
    assert page.has_content?("no robots")
    click_link "Create a Robot"
    assert_equal "/robots/new", current_path
    click_on "Make My Robot!"
    assert_equal "/robots", current_path
    click_link "Robot World Statistics"
    within ("#robot_stats") do
      assert page.has_content?("Number of Robots")
      assert page.has_content?("Average Age")
      assert page.has_content?("Robots Hired")
      assert page.has_content?("Each Department")
      assert page.has_content?("Each State")
      assert page.has_content?("Each City")
    end
  end
end
