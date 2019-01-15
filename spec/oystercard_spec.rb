require 'oystercard'

describe OysterCard do

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

  it "should deduct payment from balance on demand" do
    deduct_amount = 5
    @card.top_up(10)
    expect { @card.deduct(deduct_amount) }.to change { @card.balance }.by(-deduct_amount)
  end

  it "should be not in journey by default" do
    expect(@card).to_not be_in_journey
  end

  it "should be in journey when touched in" do
    @card.touch_in
    expect(@card).to be_in_journey # Predicate matcher where in_journey is the specified predicate matcher method name.
  end

  it "should not be in journey when touched out" do
    @card.touch_out
    expect(@card).to_not be_in_journey
  end

end
