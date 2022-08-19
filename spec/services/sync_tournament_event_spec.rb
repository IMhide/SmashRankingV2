RSpec.describe SyncTournamentEvent, type: :service do
  context 'with invalid parameters' do
    it 'raise an exception'
  end

  context 'with valid parameters' do
    it 'creates participations'
    it 'creates new Player when not on DB'
    it 'doesn\'t creates new Player is in DB'
    it 'links participation to Player'
    it 'launches GetMatchesWorker'
  end
end
