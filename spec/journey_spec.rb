require 'journey'
require 'oystercard'

describe Journey, :journey do
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  describe '#start' do
    it 'remembers entry_station' do
      subject.start(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#end' do
    it 'remebers exit_station' do
      subject.end(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#complete' do
    it 'returns true when both entry station and exit station exist' do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject).to be_complete
    end

    it 'returns false when the entry station is missing' do
      subject.end(exit_station)
      expect(subject).not_to be_complete
    end

    it 'returns false when the exit station is missing' do
      subject.start(entry_station)
      expect(subject).not_to be_complete
    end

    it 'returns false if both station are missing' do
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    it 'returns minimum fare if a journey is completed' do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end

    it 'returns penalty fare if a journey is not completed' do
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end
  end
end
