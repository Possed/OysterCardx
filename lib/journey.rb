class Journey

  def start_journey(entry_station)
    @journey = Hash.new(2)
    @journey[:entry_station] = entry_station
  end
end
