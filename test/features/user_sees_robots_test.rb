require_relative "../test_helper"

class UserSeesRobotsTest < FeatureTest

  def test_users_sees_robots
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot1 = robot_world.create(robot1_data)
    robot2_data = {:name => "Siracha", :city => "Little Rock", :state => "Arkansas", :created => "1880", :hired => "1990", :dept => "Baby"}
    robot2 = robot_world.create(robot2_data)

    visit '/robots'

    within("#robot_list") do
      assert page.has_content?("Archy")
      assert page.has_content?("Siracha")
    end
  end

end
