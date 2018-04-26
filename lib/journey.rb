class Journey
  def initialize
    @journey = Hash.new
  end

  def start_journey(entry_station)

    @journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @journey[:exit_station] = exit_station
  end
end
