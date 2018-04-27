require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  def initialize(journey_class = Journey)
    @balance = 0
    @history = []
    @journey_class = journey_class


  end

  def top_up(amount)
    raise "maximim balance of £#{MAXIMUM_BALANCE} exceeded" if exceed_limit?
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'insufficient funds available' if balance < MINIMUM_BALANCE
    entry_penalty if in_journey?
    @journey = @journey_class.new
    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    exit_penalty unless in_journey?
    @journey.end_journey(exit_station)
    deduct_fare(MINIMUM_BALANCE)
    adds_journey
  end

  def in_journey?
    !!journey
  end

  def entry_penalty
    @history << journey
    deduct_fare(PENALTY)
  end

  def exit_penalty
    @journey = @journey_class.new
    deduct_fare(PENALTY)
  end

  private
  def exceed_limit?(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def adds_journey
    @history << journey
    @journey = nil
  end

end
