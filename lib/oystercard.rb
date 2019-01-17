require_relative 'station'
require_relative 'journey'
require_relative 'journey_list'

class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MINIMUM_FARE = 1.freeze
  PENALTY_FARE = 6.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance #:journey_list, :journey

  def initialize(balance = DEFAULT_BALANCE) # Design choice! Dependency injection could also be used but not necessary here.
    @balance = balance
    @journey_list = JourneyList.new(Journey.new) # Hard coding instances is NOT dependency injection!
    # @current_journey
    # @journey = Journey.new
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance >= MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    @journey_list.journey.new_journey? ? false : true
  end

  def touch_in(entry_station)
    fail "You do not have enough in your balance!" if @balance < MINIMUM_BALANCE # No need to throw a raise!
    fare
    @journey_list.journey.log_entry_station(entry_station)
  end

  def touch_out(exit_station)
    #@journey_log[:entry_station] == nil ? fare :
    @journey_list.journey.log_exit_station(exit_station)
    fare
    record_journey_and_finish

    # @entry_station = nil
  end

  def show_journey_list
    @journey_list.journey_list
  end

  def show_current_journey
    @journey_list.journey.journey_log
  end
  # def check_journey
  #
  # end

  private

  # def entry_penalty?
  #   @journey.new_journey? ? false : true
  # end

  def add_zone_fare
    entry_zone = (/\d+/).match(@journey_list.journey.journey_log[:entry])
    exit_zone = (/\d+/).match(@journey_list.journey.journey_log[:exit])
    zone_difference = (exit_zone[0].to_i - entry_zone[0].to_i).abs
  end

  def fare
     deduct(PENALTY_FARE) unless @journey_list.journey.new_journey? || @journey_list.journey.complete_journey?
     deduct(MINIMUM_FARE + add_zone_fare) if @journey_list.journey.complete_journey?
  end

  def deduct(amount = MINIMUM_FARE)
    @balance -= amount
  end

  def record_journey_and_finish
    # @journey_list.journey_list[Time.now] = @journey_list.journey.journey_log
    @journey_list.add_journey
    @journey_list.create_new_journey
  end

end
