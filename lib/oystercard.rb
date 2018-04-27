require_relative 'journey'

class Oystercard
  attr_reader :balance, :history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise "maximim balance of £#{MAXIMUM_BALANCE} exceeded" if exceed_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station, journey = Journey.new)
    raise 'insufficient funds available' if insufficient_funds?
    deduct_fare(@journey.fare) if touch_out_missed?
    @journey = journey
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.end(exit_station)
    deduct_fare(@journey.fare)
    save_journey
    reset_journey
  end

  private
  def touch_out_missed?
    !@journey.nil?
  end

  def insufficient_funds?
    balance < MINIMUM_BALANCE
  end

  def exceed_limit?(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def save_journey
    @history << journey
  end

  def reset_journey
    @journey = nil
  end
end
