require 'station'
describe Station do
  let(:a_station) { Station.new(:bank, 5) }

  describe '#initalize' do
    it 'should assign a name to the station' do
      expect(a_station.name).to eq :bank
    end
    it 'should assign a zone to the station' do
      expect(a_station.zone).to eq 5
    end
  end
end
