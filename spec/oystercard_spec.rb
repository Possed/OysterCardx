require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:normal_fare) { 1 }
  let(:journey) { double :journey, start: entry_station, end: exit_station, entry_station: entry_station, exit_station: exit_station }

  describe '#initialize' do

    it 'has balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it 'it has a maximum balance' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error "maximim balance of £#{Oystercard::MAXIMUM_BALANCE} exceeded"
    end

    it 'has an empty list of journeys by default' do
      expect(subject.history).to eq []
    end

  end

  describe '#top_up' do
    it 'tops up balance by 10' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end
  end

  describe '#touch_in', :touch_in do
    it 'does not let user touch in with 0 balance' do
      expect { subject.touch_in(entry_station) }.to raise_error 'insufficient funds available'
    end

    it 'remembers entry station when touch in is called' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station, journey)
      expect(subject.journey.entry_station).to eq entry_station
    end
  end

  describe '#touch_out', :touch_out do
    before(:each) do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station, journey)
    end

    it 'remembers the exit station' do
      allow(journey).to receive(:fare).and_return(normal_fare)
      subject.touch_out(exit_station)
      last_journey = subject.history.last
      expect(last_journey.exit_station).to eq exit_station
    end

    it 'deducts normal fare for a complete journey' do
      allow(journey).to receive(:fare).and_return(normal_fare)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-normal_fare)
    end

    it 'saves the journey' do
      allow(journey).to receive(:fare).and_return(normal_fare)
      subject.touch_out(exit_station)
      expect(subject.history).to include(journey)
    end

    it 'resets the journey' do
      allow(journey).to receive(:fare).and_return(normal_fare)
      subject.touch_out(exit_station)
      expect(subject.journey).to be_nil
    end
  end
end
