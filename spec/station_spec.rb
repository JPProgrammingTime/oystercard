require 'station'

describe Station do

  it 'Station has a name and a zone' do
    station = Station.new('Bank', 1)
    expect(station.name).to eq 'Bank'
  end

  it 'Station has a zone' do
    station = Station.new('Bank', 1)
    expect(station.zone).to eq 1
  end
end

