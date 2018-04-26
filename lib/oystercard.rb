require_relative 'station'
require_relative 'journey'

# Oystercard class
class Oystercard
  attr_reader :balance, :history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @limit = MAXIMUM_BALANCE
    @minimum = MINIMUM_BALANCE
    @history = []
    @journey_class = journey_class
    @penalty = 6

  end

  def top_up(amount)
    raise "maximim balance of £#{@limit} exceeded" if balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station)
    @journey = @journey_class.new
    raise 'insufficient funds available' if balance < @minimum
    entry_penalty if in_journey?
    journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    exit_penalty unless in_journey?
    @journey.end_journey(exit_station)
    deduct_fare(@minimum)
    adds_journey
  end

  def in_journey?
    !!journey
  end

  def entry_penalty
    @history << journey
    deduct_fare(@penalty)
  end

  def exit_penalty
    # @journey = Hash.new
    deduct_fare(@penalty)
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end

  def adds_journey
    @history << journey
    @journey = nil
  end

end
