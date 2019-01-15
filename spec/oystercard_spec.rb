require 'oystercard'

describe OysterCard do

  let(:station) { double :station }
  before(:each) do
    @card = OysterCard.new
  end

  describe 'setting up the OysterCard' do

    it 'should have an initial balance equal to default balance' do
      expect(@card.balance).to eq(OysterCard::DEFAULT_BALANCE)
    end

    it 'should have a default balance equal to 0' do
      expect(OysterCard::DEFAULT_BALANCE).to eq(0)
    end

    it 'should respond to "top_up" method' do
      top_up_amount = 10
      expect { @card.top_up(top_up_amount) }.to change { @card.balance }.by(top_up_amount)
    end

  end

  describe 'consumer protections' do

    it 'should have a maximum balance limit of £90' do
      expect(OysterCard::MAXIMUM_BALANCE).to eq(90)
    end

    it 'topping up to more than the maximum balance should raise an error' do
      @card.top_up(40)
      expect { @card.top_up(52) }.to raise_error(OysterCard::MAX_BALANCE_ERROR)
    end

  end

  it "should deduct minimum fare of £1 from balance at touch out" do
    @card.top_up(10)
    expect { @card.touch_out(station) }.to change { @card.balance }.by(-1)
  end

  it "should be not in journey by default" do
    expect(@card).to_not be_in_journey
  end

  it "should be in journey when touched in" do
    @card.top_up(5)
    @card.touch_in(station)
    expect(@card).to be_in_journey # Predicate matcher where in_journey is the specified predicate matcher method name.
  end

  it "should not be in journey when touched out" do
    @card.top_up(5)
    @card.touch_in(station)
    @card.touch_out(station)
    expect(@card).to_not be_in_journey
  end

  it "should not touch in if balance is below £1" do
    expect { @card.touch_in(station) }.to raise_error "You do not have enough in your balance!"
  end

  it "should remember entry station at touch in" do
    @card.top_up(5)
    @card.touch_in(station)
    expect(@card.entry_station).to eql(station)
  end

  it "should forget entry station at touch out by setting it to nil" do
    @card.top_up(5)
    @card.touch_in(station)
    @card.touch_out(station)
    expect(@card.entry_station).to eql(nil)
  end

  it "should return the journey date and time" do
    @card.top_up(5)
    @card.touch_in(station)
    allow(Time).to receive(:now).and_return("2019-01-15 15:45:11 +0000")
    @card.touch_out(station)
    expect(@card.journeys.key?("2019-01-15 15:45:11 +0000")).to eql(true)
  end

  it "should return an empty list of journeys by default" do
    expect(@card.journeys).to be_empty
  end

  it "should return journey station as Aldgate East and Wimbledon" do
    @card.top_up(5)
    @card.touch_in("Aldgate East")
    allow(Time).to receive(:now).and_return("2019-01-15 15:45:11 +0000")
    @card.touch_out("Wimbledon")
    expect(@card.journeys["2019-01-15 15:45:11 +0000"]).to eql({:entry_station => "Aldgate East", :exit_station => "Wimbledon"})
  end

end
