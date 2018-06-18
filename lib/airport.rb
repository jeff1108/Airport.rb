require_relative 'plane.rb'
require_relative 'weather.rb'

class Airport
  attr_reader :planes, :capacity, :weather
  DEFAULT_CAPACITY = 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @planes = []
    @capacity = capacity
  end

  def takeoff_plane(plane, weather)
    weather.random_weather
    fail "Can't takeoff as stormy weather" if weather.stormy?
    fail "Already takeoff" if plane.flying?
    plane.takeoff
    @planes.delete(plane)
  end

  def land_plane(plane, weather)
    weather.random_weather
    fail "Can't land as airport full!" if full?
    fail "Can't land as stormy weather" if weather.stormy?
    fail "Already at the airport" unless plane.flying?
    plane.land
    @planes << plane  #use instance variable to store plane
  end

#  def plane
#    @plane    #return all landed plane
#  end

  private

  def full?
    @planes.length >= @capacity
  end

end
