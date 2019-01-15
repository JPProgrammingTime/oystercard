require_relative 'station'
require_relative 'journey'

class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance, :current_journey, :journeys
  attr_accessor :journey_log

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = {}
    # @current_journey
    @journey_log
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
    @journey_log = Journey.new(entry_station.name)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @journey_log.journey_hash[:exit_station] = exit_station.name
    @journeys[Time.now] = @journey_log.journey_hash
    # @entry_station = nil
  end

  # def check_journey
  #
  # end

  private

  def deduct(amount)
    @balance -= amount
  end

end
