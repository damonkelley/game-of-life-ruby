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
