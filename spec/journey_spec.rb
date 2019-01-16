require 'journey'
require 'station'

describe Journey do

  before(:each) do
    @journey = Journey.new
    @journey_log = { entry: nil, exit: nil }
    @entry_station = Station.new("ENTRY", 1)
    @exit_station = Station.new("EXIT", 1)
  end

  it 'Journey has a nil entry and exit log' do
    expect(@journey.journey_log).to eql(@journey_log)
  end

  it 'should return entry station name' do
    @journey.log_entry_station(@entry_station)
    expect(@journey.journey_log[:entry]).to eql("ENTRY")
  end

  it 'should return exit station name' do
    @journey.log_exit_station(@exit_station)
    expect(@journey.journey_log[:exit]).to eql("EXIT")
  end

  it "should return true as entry is not nil" do
    @journey.log_entry_station(@entry_station)
    expect(@journey).to be_entry_log
  end

  it "should return true for a new journey, i.e. both entry and exit are nil" do
    expect(@journey).to be_new_journey
  end
end
