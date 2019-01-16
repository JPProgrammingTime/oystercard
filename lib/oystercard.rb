require_relative 'station'
require_relative 'journey'

class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MINIMUM_FARE = 1.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance, :current_journey, :journeys
  attr_accessor :journey_log

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = {}
    # @current_journey
    @journey_log = Journey.new
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance >= MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    (@journey_log.journey_hash[:entry_station] == nil && @journey_log.journey_hash[:exit_station] == nil) ? false : true
  end

  def touch_in(entry_station)
    fail "You do not have enough in your balance!" if @balance < MINIMUM_BALANCE # No need to throw a raise!
    fare
    @journey_log.journey_hash[:entry_station] = entry_station.name
  end

  def touch_out(exit_station)
    @journey_log.journey_hash[:exit_station] = exit_station.name
    @journeys[Time.now] = @journey_log.journey_hash
    @journey_log = Journey.new
    fare
    # @entry_station = nil
  end

  # def check_journey
  #
  # end

  private

  def fare
    if @journey_log.journey_hash[:entry_station] == nil || @journey_log.journey_hash[:exit_station] == nil
      deduct(6)
    else
      deduct(MINIMUM_FARE)
    end
  end

  def deduct(amount = MINIMUM_FARE)
    @balance -= amount
  end

end
