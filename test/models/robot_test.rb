require_relative "../test_helper"

class RobotTest < Minitest::Test
  attr_reader :robot

  def setup
    @robot = Robot.new({"id" => "3", "name" => "Abigail",
            "city" => "Paris", "state" => "Tennessee",
            "created" => "1987", "hired" => "2000",
            "dept" => "Security"})
  end

  def test_assigns_attributes_correctly
    assert_equal "3", robot.id
    assert_equal "1987", robot.created
    assert_equal "Security", robot.dept
  end

  def test_can_get_robot_age
    assert_equal 29, robot.age
  end
end
