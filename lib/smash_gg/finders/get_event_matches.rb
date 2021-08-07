module SmashGg
  class GetEventMatches < BaseFinder
    MatchQuery = GraphClient.parse <<-'GRAPHQL'
    query($event_id: ID!, $page: Int!, $group_phase_id: [ID]) {
      event(id: $event_id) {
        sets(page: $page, perPage: 55, filters: {phaseGroupIds: $group_phase_id}) {
          nodes {
            round
            winnerId
            completedAt
            slots {
              entrant {
                id
                participants {
                  verified
                  player {
                    id
                    prefix
                    gamerTag
                  }
                }
              }
              standing{
                stats{
                  score{
                    value
                  }
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

    PhaseGroupQuery = GraphClient.parse <<-'GRAPHQL'
    query($event_id: ID!) {
      event(id: $event_id) {
        phaseGroups{
          bracketType
          id
        }
      }
    }
    GRAPHQL

    def initialize(event_remote_id:)
      @event_remote_id = event_remote_id
    end

    def call
      Array.new(total_page) { |i| matches_query(page: i + 1) }.flatten
    end

    def total_page
      GraphClient.query(MatchQuery, variables: {event_id: @event_remote_id, page: 1, group_phase_id: de_phases_ids}).original_hash.dig(
        'data', 'event', 'sets', 'pageInfo', 'totalPages'
      )
    end

    def matches_query(page: 1)
      results = GraphClient.query(MatchQuery, variables: {event_id: @event_remote_id, page: page, group_phase_id: de_phases_ids}).original_hash.dig(
        'data', 'event', 'sets', 'nodes'
      )
    end

    def de_phases_ids
      @result ||= GraphClient.query(PhaseGroupQuery, variables: {event_id: @event_remote_id}).original_hash.dig(
        'data', 'event', 'phaseGroups'
      ).select do |b|
                    b['bracketType'] == 'DOUBLE_ELIMINATION'
                  end.map do |c|
        c['id']
      end
    end
  end
end
