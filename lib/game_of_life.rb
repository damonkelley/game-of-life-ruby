class Generation
  def initialize(rules:, coordinate_tracker:)
    @rules = rules
    @coordinate_tracker = coordinate_tracker
  end

  def evolve(world, constraint, coordinate = Coordinate.new(0, 0))
    return world unless constraint.continue?

    neighbors = coordinate_tracker.neighbors_for(coordinate)
    next_contents = rules.alive_in_next_generation?(coordinate, neighbors)
    evolve(world.set(coordinate, next_contents), constraint, coordinate_tracker.next)
  end

  private

  attr_reader :rules, :coordinate_tracker
end

class Coordinate
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def ==(other)
    other.same_location?(latitude, longitude)
  end

  def same_location?(latitude, longitude)
    self.latitude == latitude && self.longitude == longitude
  end

  alias eql? :==

  def hash
    latitude ^ longitude
  end

  def inspect
    "<#{self.class} (#{latitude},#{longitude})"
  end
end

class World
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.empty
    World.new({})
  end

  def set(coordinate, contents)
    World.new(grid.merge(coordinate => contents))
  end

  def at(coordinate)
    grid[coordinate]
  end

  def ==(other)
    other.equal_grid?(grid)
  end

  def equal_grid?(grid)
    self.grid == grid
  end

  def inspect
    "<#{self.class} #{grid}>"
  end
end

class LivingCell
  def ==(other)
    other.alive?
  end

  def alive?
    true
  end
end
