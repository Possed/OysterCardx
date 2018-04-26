require 'journey'
require 'oystercard'

describe Journey do
  let(:card) { Oyestercard.new }
  describe '#start_journey' do

    it 'remembers entry_station when touch_in is called' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.journey[:entry_station]).to eq(entry_station)
    end

  end
end
