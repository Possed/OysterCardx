require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

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

  describe '#touch_in' do

    it 'does not let user touch in with 0 balance' do
      expect { subject.touch_in(entry_station) }.to raise_error 'insufficient funds available'
    end

    # it 'remembers entry_station when touch_in is called' do
    #   subject.top_up(5)
    #   subject.touch_in(entry_station)
    #   expect(subject.journey[:entry_station]).to eq(entry_station)
    # end

  end

  describe '#touch_out' do

    before(:each) do
      subject.top_up(5)
      subject.touch_in(entry_station)
    end

    it 'deducts minimum balance when touch_out is called' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'remembers the journey when touch_out is called' do
      subject.touch_out(exit_station)
      expect(subject.history).to include(:entry_station => entry_station, :exit_station => exit_station)
    end

    it 'touch_in and touch_out creates one journey' do
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 1
    end

    it 'returns false when touch_out called' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

  end

  describe '#in_jouney' do

    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'returns true when touch_in called' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

  end

end
