class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance, :entry_station, :exit_station, :current_journey, :journeys

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station
    @journeys = {}
    @current_journey = {}
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance >= MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(entry_station)
    fail "You do not have enough in your balance!" if @balance < MINIMUM_BALANCE # No need to throw a raise!
    @entry_station = entry_station
    @current_journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @current_journey[:exit_station] = exit_station
    @journeys[Time.now] = @current_journey
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
