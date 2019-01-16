class Journey

  attr_accessor :entry_station, :exit_station, :journey_hash

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey_hash = { :entry_station => @entry_station, :exit_station => @exit_station }
  end
end
