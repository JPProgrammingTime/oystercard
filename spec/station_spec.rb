require 'station'

describe Station do

  before(:each) do
    station = Station.new("Bank", 1)
  end

  it 'Station has a name' do
    expect(station.name).to eql("Bank")
  end

  it 'Station has a zone' do
    expect(station.zone).to eql(1)
  end
end
