class Journey

  attr_accessor :entry_station, :exit_station, :journey_hash

  def initialize(entry_station = "NO ENTRY!", exit_station = "NO EXIT!")
    @entry_station = entry_station
    @exit_station = exit_station
    @journey_hash = { :entry_station => @entry_station, :exit_station => @exit_station }
  end
end
