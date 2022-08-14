RSpec.describe CreateTournamentBySlug, type: :service do
  subject {described_class.new(tournament: tournament).call}
  let (:tournament) {FactoryBot.build(:tournament)}

  context 'Tournament with correct slug' do
    let (:result) { {name: 'Genesis 8', tournament_remote_id: 424242, dated_at: DateTime.now} }
    before do
      allow(SmashGg::Finders::GetFinishedTournamentBySlug).to receive(:call).and_return(result)
    end


    it 'returns a tournament' do
      expect(subject.class).to eq(Tournament)
    end

    it 'assigns remote attribute' do
      expect(subject.name).to eq(result[:name])
    end
  end

  context 'Tournament with slug' do
    before do
      allow(SmashGg::Finders::GetFinishedTournamentBySlug).to receive(:call).and_return({})
    end

    it 'returns false' do
      expect(subject).to eq(false)
    end
  end
end
