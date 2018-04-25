require_relative 'station'

# Oystercard class
class Oystercard
  attr_reader :balance, :history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @limit = MAXIMUM_BALANCE
    @minimum = MINIMUM_BALANCE
    @history = []

  end

  def top_up(amount)
    raise "maximim balance of £#{@limit} exceeded" if balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'insufficient funds available' if balance < @minimum
    # @history << journey if in_journey?
    @journey = Hash.new(2)
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    unless in_journey?
      @journey = Hash.new(2)
    end
    deduct(@minimum)
    @journey[:exit_station] = exit_station
    adds_journey
  end

  def in_journey?
    !!journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def adds_journey
    @history << journey
    @journey = nil
  end

end
