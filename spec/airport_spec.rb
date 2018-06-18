require_relative '../lib/airport.rb'
require_relative '../lib/weather.rb'


describe Airport do
  airport = Airport.new
  it { is_expected.to respond_to(:takeoff_plane) }

  #plane = Plane.new
  #it { expect(plane.takeoff).to eq(true) }

  #it 'takeoff plane' do
    #plane = airport.takeoff_plane
    #expect(plane).to be_takeoff
  #end
  describe '#takeoff' do
    it 'takeoff a plane' do
      #plane = Plane.new
      plane = double(:plane, flying?: false, land: true, takeoff: false)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      subject.takeoff_plane(plane, weather)
      expect(subject.planes).to eq []
    end

    it 'does not allow plane to takeoff' do
      #plane = Plane.new
      #allow(weather).to receive(:stormy?).and_return(true)
      plane = double(:plane, flying?: false, takeoff: false)
      weather = double(:weather, stormy?: true, random_weather: "stormy")
      message = "Can't takeoff as stormy weather"
      expect { subject.takeoff_plane(plane, weather) }.to raise_error message
    end

    it 'allow plane to takeoff' do
      plane = double(:plane, flying?: false, takeoff: false)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      message = "Can takeoff"
      expect { subject.takeoff_plane(plane, weather) }.not_to raise_error message
    end

    it "already takeoff" do
      plane = double(:plane, flying?: true, takeoff: true)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      message = "Already takeoff"
      expect { subject.takeoff_plane(plane, weather) }.to raise_error message
    end
  end

  it { is_expected.to respond_to(:land_plane).with(2).argument }

  it { is_expected.to respond_to(:planes) }

  describe '#land' do
    it 'land a plane' do
      #plane = Plane.new
      plane = double(:plane, flying?: true, land: false)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      #retrun the plane we land
      expect(subject.land_plane(plane, weather)).to include plane #eq plane
    end

    it 'raise an error when full' do
      #subject.land_plane(Plane.new)
      #plane = Plane.new
      plane = double(:plane, flying?: true, land: false)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      subject.capacity.times { subject.land_plane(plane, weather) }
      expect { subject.land_plane(plane, weather) }.to raise_error "Can't land as airport full!"
    end

    it 'does not allow plane to land' do
      #plane = Plane.new
      plane = double(:plane, flying?: true, land: false)
      weather = double(:weather, stormy?: true, random_weather: "stormy")
      message = "Can't land as stormy weather"
      expect { subject.land_plane(plane, weather) }.to raise_error message
    end

    it 'allow plane to land' do
      #plane = Plane.new
      plane = double(:plane, flying?: true, land: false)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      message = "Can land"
      expect { subject.land_plane(plane, weather) }.not_to raise_error message
    end

    it "already landed" do
      plane = double(:plane, flying?: false, land: true)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      message = "Already at the airport"
      expect { subject.land_plane(plane, weather) }.to raise_error message
    end

  end
=begin
  describe '#plane' do
    it 'returns landed planes' do
      plane = Plane.new
      subject.land_plane(plane)
      #return the plane we just landed
      expect(subject.plane).to eq plane
    end
  end
=end
  it 'has a default value' do
    expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  describe '#initialize' do
    subject { Airport.new }
    let(:plane) { double(:plane, flying?: true, land: false, takeoff: true) }
    it 'default capacity' do
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      described_class::DEFAULT_CAPACITY.times { subject.land_plane(plane, weather) }
      expect { subject.land_plane(plane, weather) }.to raise_error "Can't land as airport full!"
    end
    it 'it have a variable capacity' do
      plane = double(:plane, flying?: true, land: false, takeoff: true)
      airport = Airport.new(30)
      weather = double(:weather, stormy?: false, random_weather: "sunny")
      30.times { airport.land_plane(plane, weather) }
      expect { airport.land_plane(plane, weather) }.to raise_error "Can't land as airport full!"
    end

end



end
