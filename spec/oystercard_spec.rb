require 'oystercard'

describe Oystercard do
  it 'has balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'tops up balance by 10' do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it 'it has a maximum balance' do
    limit = Oystercard::MAXIMUM_BALANCE
    subject.top_up(limit)
    expect { subject.top_up(1) }.to raise_error "maximim balance of £#{limit} exceeded"
  end

  it 'returns true when touch_in called' do
    minimum = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'returns false when touch_out called' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'does not let user touch in with 0 balance' do
    expect { subject.touch_in }.to raise_error 'insufficient funds available'
  end

  it 'deducts minimum balance when touch_out is called' do
    minimum = Oystercard::MINIMUM_BALANCE
    subject.top_up(5)
    subject.touch_in
    expect { subject.touch_out }.to change { subject.balance }.by(-minimum)
  end
end
