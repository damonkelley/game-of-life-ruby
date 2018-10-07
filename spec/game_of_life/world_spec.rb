require 'spec_helper'
require 'game_of_life'

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
