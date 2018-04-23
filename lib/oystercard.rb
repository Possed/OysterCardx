# Oystercard class
class Oystercard
  attr_reader :balance, :history

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @limit = MAXIMUM_BALANCE
    @minimum = MINIMUM_BALANCE
  end

  def top_up(amount)
    raise "maximim balance of £#{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'insufficient funds available' if @balance < @minimum
    @history = entry_station
  end

  def touch_out
    deduct(@minimum)
    @history = nil
  end

  def in_journey?
    !!@history
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
