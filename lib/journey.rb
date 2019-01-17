class Journey

  #attr_accessor :entry_station, :exit_station, :journey_hash
  attr_reader :journey_log

  def initialize#(entry_station = nil, exit_station = nil)
    # @entry_station = entry_station
    # @exit_station = exit_station
    @journey_log = { entry: nil, exit: nil }
  end

  def log_entry_station(entry_station)
    @journey_log[:entry] = "#{entry_station.name.to_sym}" + ":" + " Zone #{entry_station.zone}"
  end

  def log_exit_station(exit_station)
    @journey_log[:exit] = "#{exit_station.name.to_sym}" + ":" + " Zone #{exit_station.zone}"
  end

  # def entry_log?
  #   @journey_log[:entry] != nil ? true : false
  # end

  def complete_journey?
    @journey_log[:entry] != nil && @journey_log[:exit] != nil ? true : false
  end

  def new_journey?
      @journey_log[:entry] == nil && @journey_log[:exit] == nil ? true : false
  end
end
