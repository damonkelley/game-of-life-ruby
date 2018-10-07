require 'spec_helper'
require 'game_of_life'

RSpec.describe Generation do
  class TestConstraint
    def initialize(should_continue: [])
      @should_continue = should_continue
    end

    def continue?
      @should_continue.shift
    end
  end

  class TestCoordinateTracker
    def initialize
      @next_coordinates = [
        Coordinate.new(0, 1),
        Coordinate.new(1, 0),
        Coordinate.new(-1, 0),
        Coordinate.new(0, -1)
      ]
    end

    def neighbors_for(_coordinate)
      {}
    end

    def next
      @next_coordinates.shift
    end
  end

  class TestRules
    def alive_in_next_generation?(_coordinate, _neighbors)
      LivingCell.new
    end
  end

  let(:coordinate_tracker) { TestCoordinateTracker.new }
  let(:rules) { TestRules.new }

  context 'when the constraint cannot continue viewing the board' do
    let(:constraint) { TestConstraint.new(should_continue: [false]) }

    it 'will not evolve the world' do
      new_world = Generation.new(rules: rules, coordinate_tracker: coordinate_tracker)
                            .evolve(World.empty, constraint)

      expect(new_world).to eq(World.empty)
    end
  end

  context 'when constraint can view the board' do
    let(:constraint) { TestConstraint.new(should_continue: [true, true, true, false]) }

    it 'will evolve the world' do
      new_world = Generation.new(rules: rules, coordinate_tracker: coordinate_tracker)
                            .evolve(World.empty, constraint)

      expected_world = World.empty
                            .set(Coordinate.new(0, 0), LivingCell.new )
                            .set(Coordinate.new(0, 1), LivingCell.new)
                            .set(Coordinate.new(1, 0), LivingCell.new)

      expect(new_world).to eq expected_world
    end
  end
end

RSpec.describe World do
  it 'will place a call at a coordinate' do
    world = World.empty
                 .set(Coordinate.new(0, 0), 'contents')

    expect(world.at(Coordinate.new(0, 0))).to eq 'contents'
  end

  it 'is equal to another world based on its contents' do
    world = World.empty
                 .set(Coordinate.new(0, 0), 'contents')

    expect(world).not_to eq World.empty
    expect(World.empty).to eq World.empty
  end
end
