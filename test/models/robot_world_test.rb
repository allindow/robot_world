require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_total_starts_at_zero
    assert_equal 0, robot_world.all.count

    robot_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot_world.create(robot_data)

    assert_equal 1, robot_world.all.count
  end

  def test_it_creates_a_robot
    robot_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot_world.create(robot_data)
    robot = robot_world.find(robot_world.all.count)
    assert_instance_of Robot, robot
    assert_equal "Archy", robot.name
    assert_equal "Horticulture", robot.dept
  end
end
