class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def start(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !(no_entry_station? || no_exit_station?)
  end

  def fare
    return PENALTY_FARE unless complete?
    MINIMUM_FARE
  end

  private

  def no_entry_station?
    @entry_station.nil?
  end

  def no_exit_station?
    @exit_station.nil?
  end
end
