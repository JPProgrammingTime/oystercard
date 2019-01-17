require_relative 'journey'

class JourneyList

  attr_reader :journey, :journey_list

  def initialize(journey = Journey.new)
    @journey_list = {}
    @journey = journey
  end

  def add_journey
    @journey_list[Time.now] = @journey.journey_log
  end

  # def add_entry_to_journey(entry_station)
  #   @journey.log_entry_station(entry_station)
  # end
  #
  # def add_exit_to_journey(exit_station)
  #   @journey.log_exit_station(exit_station)
  # end

  # def show_journey_list
  #   @journey_list.each do |time_date, the_journey|
  #     puts "#{time_date}: #{the_journey}"
  #   end
  # end
  #
  # def show_current_journey
  #   @journey.journey_log.each do |time_date, current_journey|
  #     puts "#{time_date}: #{current_journey}"
  #   end
  # end

  def create_new_journey
    @journey = Journey.new
  end

end
