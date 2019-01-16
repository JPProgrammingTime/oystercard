require_relative 'station'
require_relative 'journey'

class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MINIMUM_FARE = 1.freeze
  PENALTY_FARE = 6.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance, :journey_list, :journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_list = {}
    # @current_journey
    @journey = Journey.new
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance >= MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    @journey.new_journey? ? false : true
  end

  def touch_in(entry_station)
    fail "You do not have enough in your balance!" if @balance < MINIMUM_BALANCE # No need to throw a raise!
    fare(entry_penalty?)
    @journey.log_entry_station(entry_station)
  end

  def touch_out(exit_station)
    #@journey_log[:entry_station] == nil ? fare :
    @journey.log_exit_station(exit_station)
    fare(@journey.entry_log?)
    record_journey_and_finish

    # @entry_station = nil
  end

  # def check_journey
  #
  # end

  private

  def entry_penalty?
    @journey.new_journey? ? false : true
  end

  def fare(no_penalty = true)
    no_penalty ? deduct(MINIMUM_FARE) : deduct(PENALTY_FARE)
  end

  def deduct(amount = MINIMUM_FARE)
    @balance -= amount
  end

  def record_journey_and_finish
    @journey_list[Time.now] = journey.journey_log
    @journey = Journey.new
  end

end
