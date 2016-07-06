require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.first.id
  end

  def test_total_starts_at_zero
    assert_equal 0, robot_world.all.count

    robot_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot_world.create(robot_data)

    assert_equal 1, robot_world.all.count
  end

  def test_it_creates_a_robot_and_finds_by_id
    robot_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot_world.create(robot_data)
    robot = robot_world.find(current_robot_id)
    assert_instance_of Robot, robot
    assert_equal "Archy", robot.name
    assert_equal "Horticulture", robot.dept
  end

  def test_it_collects_robot_objects_with_all
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot2_data = {:name => "Gus", :city => "New Market", :state => "TN", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.create(robot1_data)
    robot_world.create(robot2_data)
    assert_equal 2, robot_world.all.count
    assert_instance_of Robot, robot_world.all.last
    assert_instance_of Robot, robot_world.all.first
  end

  def test_it_can_update_robot_info
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot2_data = {:name => "Gus", :city => "New Market", :state => "TN", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.create(robot1_data)
    robot_world.create(robot2_data)
    update = {:name => "Augustus", :city => "New Market", :state => "Tennesse", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.update(current_robot_id + 1, update)
    robot2 = robot_world.find(current_robot_id + 1)
    assert_equal "Augustus", robot2.name
    assert_equal "Tennesse", robot2.state
  end

  def test_it_can_destroy_robot
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot2_data = {:name => "Gus", :city => "New Market", :state => "TN", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.create(robot1_data)
    robot_world.create(robot2_data)
    assert_equal 2, robot_world.all.count
    robot_world.destroy(current_robot_id)
    assert_equal 1, robot_world.all.count
    assert_equal "Gus", robot_world.all.first.name
  end

  def test_it_can_get_average_robot_age
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Guam", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot2_data = {:name => "Gus", :city => "New Market", :state => "TN", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.create(robot1_data)
    robot_world.create(robot2_data)
    assert_equal 7, robot_world.average_age
  end

  def test_it_can_generate_data_for_empty_fields
    robot_data = {:name => "", :city => "", :state => "TN", :created => "2005", :hired => "2010", :dept => "Horticulture"}
    robot_world.create(robot_data)
    refute robot_world.all.first.name == ""
    refute robot_world.all.first.city == ""
  end

  def test_it_can_get_data_by_column
    robot1_data = {:name => "Archy", :city => "Yigo", :state => "Jamaica", :created => "2001", :hired => "2015", :dept => "Horticulture"}
    robot2_data = {:name => "Gus", :city => "Yigo", :state => "Guam", :created => "2016", :hired => "2016", :dept => "Dairy"}
    robot_world.create(robot1_data)
    robot_world.create(robot2_data)
    robot_world.count_selection("city").map do |set|
      assert_equal 2, set["COUNT(city)"]
      assert_equal "Yigo", set["city"]
    end
    robot_world.count_selection("state").map do |set|
      assert_equal 1, set["COUNT(state)"]
    end
  end

end
