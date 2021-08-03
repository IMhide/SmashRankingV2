module SmashGg
  class GetEventStandings < BaseFinder
    MatchQuery = GraphClient.parse <<-'GRAPHQL'
    query($event_id: ID!, $page: Int!) {
      event(id: $event_id){
        standings(query: {page: $page, perPage: 150}) {
          nodes {
            placement
            entrant {
              isDisqualified
              seeds {
                seedNum
              }
              participants {
                verified
                player {
                  id
                  gamerTag
                  prefix
                }
              }
            }
          }
          pageInfo{
            totalPages
          }
        }
      }
    }
    GRAPHQL

    def initialize(event_remote_id:)
      @event_remote_id = event_remote_id
    end

    def call
      Array.new(total_page) { |i| seeds_query(page: i + 1) }.flatten
    end

    def total_page
      GraphClient.query(MatchQuery, variables: { event_id: @event_remote_id, page: 1 }).original_hash.dig('data',
                                                                                                          'event', 'standings', 'pageInfo', 'totalPages')
    end

    def seeds_query(page: 1)
      format GraphClient.query(MatchQuery, variables: { event_id: @event_remote_id, page: page }).original_hash.dig(
        'data', 'event', 'standings', 'nodes'
      )
    end

    private

    def format(results)
      results.map do |r|
        {
          placement: r.dig('placement'),
          seed: max_seed(r.dig('entrant', 'seeds')),
          player_id: r.dig('entrant', 'participants').first.dig('player', 'id'),
          player_name: r.dig('entrant', 'participants').first.dig('player', 'gamerTag'),
          player_team: r.dig('entrant', 'participants').first.dig('player', 'prefix'),
          dq: r.dig('entrant', 'isDisqualified'),
          verified: r.dig('entrant', 'participants').first.dig('verified')
        }
      end
    end

    def max_seed(seeds)
      seeds.map { |s| s.dig('seedNum') }.max
    end
  end
end
