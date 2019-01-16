require 'station'

describe Station do

  subject { described_class.new("Bank", 1) }

  it 'Station has a name' do
    expect(subject.name).to eql("Bank")
  end

  it 'Station has a zone' do
    expect(subject.zone).to eql(1)
  end
end
