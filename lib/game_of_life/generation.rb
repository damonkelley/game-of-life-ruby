class Generation
  def initialize(rules:, coordinate_tracker:)
    @rules = rules
    @coordinate_tracker = coordinate_tracker
  end

  def evolve(world, constraint, coordinate = Coordinate.new(0, 0))
    return world unless constraint.continue?

    neighbors = coordinate_tracker.neighbors_for(world, coordinate)
    next_contents = rules.alive_in_next_generation?(world.at(coordinate), neighbors)
    evolve(world.set(coordinate, next_contents), constraint, coordinate_tracker.next)
  end

  private

  attr_reader :rules, :coordinate_tracker
end
