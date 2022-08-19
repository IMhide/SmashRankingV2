RSpec.describe SyncTournamentEvent, type: :service do
  describe '#call' do
    context 'with invalid :remote_event_id' do
      it 'raise an exception'
    end

    context 'with valid :remote_event_id' do
      subject { described_class.new(tournament: FactoryBot.create(:tournament), remote_event_id: remote_event_id).call }

      let(:remote_event_id) { 400198 }
      let(:finder_result) { [
        {:placement=>1, :seed=>1, :player_id=>222927, :player_name=>"MkLeo", :player_team=>"T1", :dq=>nil, :verified=>true},
        {:placement=>2, :seed=>9, :player_id=>6122, :player_name=>"Glutonny", :player_team=>"Solary", :dq=>nil, :verified=>true},
        {:placement=>3, :seed=>2, :player_id=>158026, :player_name=>"Sparg0", :player_team=>"FaZe", :dq=>nil, :verified=>true},
        {:placement=>4, :seed=>4, :player_id=>158871, :player_name=>"Light", :player_team=>"Moist", :dq=>nil, :verified=>true},
        {:placement=>5, :seed=>11, :player_id=>370802, :player_name=>"Zomba", :player_team=>"SSG", :dq=>nil, :verified=>false},
        {:placement=>5, :seed=>35, :player_id=>24641, :player_name=>"Myran", :player_team=>"Paragon", :dq=>true, :verified=>true}
      ] }


      before(:each) do
        allow_any_instance_of(SmashGg::Finders::GetEventStandings).to receive(:call).and_return(finder_result)
      end

      it 'creates participations' do
        expect {subject}.to change(Participation, :count).by(6)
      end

      it 'creates new Player when not on DB' do
        expect {subject}.to change(Player, :count).by(6)
      end

      it 'doesn\'t creates new Player is in DB' do
        FactoryBot.create(:player, remote_id: 222927) 
        expect {subject}.to change(Player, :count).by(5)
      end
      it 'links participation to Player' do
        mk = FactoryBot.create(:player, remote_id: 222927) 
        expect {subject}.to change(mk.participations, :count).by(1)
      end
      it 'launches GetMatchesWorker'
    end
  end
end
