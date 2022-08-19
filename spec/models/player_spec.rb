RSpec.describe Player, type: :model do
  describe '#display_name' do
    subject { FactoryBot.build(:player, name: name, team: team).display_name }
    let(:name) { 'Oryon' }
    let(:team) { 'OPL' }

    it {expect(subject).to eq("#{team} | #{name}")}
  end
end
