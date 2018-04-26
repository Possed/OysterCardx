require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  card = Oystercard.new
  describe '#start_journey' do

    it 'remembers entry_station when touch_in is called' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect(subject[:entry_station]).to eq(entry_station)
    end

  end
end
