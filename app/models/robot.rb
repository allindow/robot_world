require 'rubygems'
require 'faker'

class Robot
attr_reader :name, :city, :state, :created, :hired, :dept, :id

  def initialize(data)
    @name      = data["name"]
    @city      = data["city"]
    @state     = data["state"]
    @created = data["created"]
    @hired     = data["hired"]
    @dept      = data["dept"]
    @id      = data["id"]
  end

  def age
    now = Time.now.utc.to_date
    now.year - created.to_i
  end

  def random_name
    Faker::Name.name
  end
  
end
