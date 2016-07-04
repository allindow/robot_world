class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def robot_data
    database.execute("SELECT * FROM robots;")
  end

  def robot_count
    robot_data.count
  end

  def average_age
    all.map do |robot|
      robot.age
    end.inject(:+)/robot_count
  end

  def hired_by_year
    database.execute("SELECT hired, COUNT(hired) FROM robots GROUP BY hired")
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

  def dept(robot)
    robot[:dept].empty? ? Faker::Commerce.department : robot[:dept]
  end

  def create(robot)
    database.execute("INSERT INTO robots (
                      name,
                      city,
                      state,
                      created,
                      hired,
                      dept
                      )
                      VALUES (?, ?, ?, ?, ?, ?);",
                      name(robot),
                      city(robot),
                      state(robot),
                      created(robot),
                      hired(robot),
                      dept(robot)
                      )
  end

  def raw_robot(id)
    robot_data.find { |data| data["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id,robot)
    database.execute("UPDATE robots SET
                      name = ?,
                      city = ?,
                      state = ?,
                      created = ?,
                      hired = ?,
                      dept = ?
                      WHERE id = ?;",
                      name(robot),
                      city(robot),
                      state(robot),
                      created(robot),
                      hired(robot),
                      dept(robot),
                      id
                      )
  end

  def destroy(id)
    database.execute("DELETE FROM robots WHERE id = ?;", id)
    # database.transaction do
    #   database['robots'].delete_if {|robot| robot["id"] == id}
    # end
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end
end
