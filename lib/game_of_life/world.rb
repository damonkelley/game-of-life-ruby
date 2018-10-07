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
