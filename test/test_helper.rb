ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'launchy'

module TestHelpers
  #create the test database
  def robot_world
    database = YAML::Store.new('db/robot_world_test')
    @database ||= RobotWorld.new(database)
  end

  def teardown
    robot_world.delete_all
    super
  end
end

Capybara.app = RobotWorldApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
