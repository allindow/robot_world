ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'launchy'
require 'sqlite3'

module TestHelpers
  #create the test database
  def robot_world
    database = SQLite3::Database.new('db/robot_world_test.db')
    database.results_as_hash = true
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
