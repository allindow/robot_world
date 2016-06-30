require 'yaml/store'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def robot_data
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    robot_data.map { |data| Robot.new(data) }
  end

  def name(robot)
    robot[:name].empty? ? Faker::Name.first_name : robot[:name]
  end

  def city(robot)
    robot[:city].empty? ? Faker::Address.city : robot[:city]
  end

  def state(robot)
    robot[:state].empty? ? Faker::Address.state : robot[:state]
  end

  def created(robot)
    robot[:created].empty? ? rand(1900..2000).to_s : robot[:created]
  end

  def hired(robot)
    robot[:hired].empty? ? rand(2001..2016).to_s : robot[:hired]
  end

  def department(robot)
    robot[:dept].empty? ? Faker::Commerce.department : robot[:dept]
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'], "name" => name(robot), "city" => city(robot), "state" => state(robot), "created" => created(robot), "hired" => hired(robot), "dept" => department(robot)}
    end
  end

  def raw_robot(id)
    robot_data.find { |data| data["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id,robot)
    database.transaction do
      target_robot = database['robots'].detect {|robot| robot["id"] == id }
      target_robot["name"] = robot[:name]
      target_robot["city"] = robot[:city]
      target_robot["state"] = robot[:state]
      target_robot["created"] = robot[:created]
      target_robot["hired"] = robot[:hired]
      target_robot["dept"] = robot[:dept]
    end
  end

  def destroy(id)
    database.transaction do
      database['robots'].delete_if {|robot| robot["id"] == id}
    end
  end

  def delete_all
    database.transaction do
      database["robots"] = []
      database["total"] = 0
    end
  end
end
